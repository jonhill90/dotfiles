-- Custom region box renderer for #region markers
-- Detects patterns like:
--   # ---------------------------------------------------------
--   #region Infrastructure Data Sources
--   # ---------------------------------------------------------
-- And renders them as fancy centered boxes

local M = {}

-- Namespace for extmarks
local ns = vim.api.nvim_create_namespace('region_boxes')

-- Function to check if a line is a separator (# ---- or # ====)
local function is_separator(line)
  return line:match('^%s*#%s*[-=]+%s*$') ~= nil
end

-- Function to check if a line is a region marker
local function is_region(line)
  return line:match('^%s*#%s*region%s+(.*)$')
end

-- Function to get the width of separator characters
local function get_separator_width(line)
  local sep = line:match('^%s*#%s*([-=]+)%s*$')
  return sep and #sep or 0
end

-- Function to create centered text with box characters
local function create_box(text, width)
  local text_len = vim.fn.strdisplaywidth(text)
  local padding = math.max(0, math.floor((width - text_len) / 2))
  local left_pad = string.rep(' ', padding)
  local right_pad = string.rep(' ', width - text_len - padding)

  local top = '┌' .. string.rep('─', width) .. '┐'
  local middle = '│' .. left_pad .. text .. right_pad .. '│'
  local bottom = '└' .. string.rep('─', width) .. '┘'

  return { top, middle, bottom }
end

-- Function to render region boxes in a buffer
function M.render_regions(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Clear existing extmarks
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local i = 1

  while i <= #lines do
    -- Check for pattern: separator, region, separator
    if i + 2 <= #lines then
      local line1 = lines[i]
      local line2 = lines[i + 1]
      local line3 = lines[i + 2]

      if is_separator(line1) and is_separator(line3) then
        local region_text = is_region(line2)
        if region_text then
          -- Get the width from the separator
          local width = math.max(get_separator_width(line1), get_separator_width(line3))

          -- Create the box
          local box_lines = create_box(region_text, width)

          -- Conceal the original lines and add virtual text
          -- Line 1 (top separator) - show top box border
          vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
            virt_text = { { box_lines[1], 'RegionBox' } },
            virt_text_pos = 'overlay',
          })

          -- Line 2 (region) - show middle with text
          vim.api.nvim_buf_set_extmark(bufnr, ns, i, 0, {
            virt_text = { { box_lines[2], 'RegionBox' } },
            virt_text_pos = 'overlay',
          })

          -- Line 3 (bottom separator) - show bottom box border
          vim.api.nvim_buf_set_extmark(bufnr, ns, i + 1, 0, {
            virt_text = { { box_lines[3], 'RegionBox' } },
            virt_text_pos = 'overlay',
          })

          -- Skip past these 3 lines
          i = i + 3
        else
          i = i + 1
        end
      else
        i = i + 1
      end
    else
      i = i + 1
    end
  end
end

-- Function to clear region boxes in a buffer
function M.clear_regions(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

-- Set up autocmds to render on buffer enter and changes
function M.setup()
  -- Define highlight group for region boxes (blue)
  vim.api.nvim_set_hl(0, 'RegionBox', { fg = '#2563EB', bold = true })

  -- Set up autocmds
  local group = vim.api.nvim_create_augroup('RegionBoxes', { clear = true })

  -- Render boxes in normal mode
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    group = group,
    pattern = { '*.tf', '*.hcl', '*.js', '*.ts', '*.lua', '*.py', '*.go', '*.rs', '*.c', '*.cpp' },
    callback = function(args)
      M.render_regions(args.buf)
    end,
  })

  -- Clear boxes when entering insert mode
  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    group = group,
    pattern = { '*.tf', '*.hcl', '*.js', '*.ts', '*.lua', '*.py', '*.go', '*.rs', '*.c', '*.cpp' },
    callback = function(args)
      M.clear_regions(args.buf)
    end,
  })
end

return M
