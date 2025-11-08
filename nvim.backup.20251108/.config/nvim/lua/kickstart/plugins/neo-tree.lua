-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      use_libuv_file_watcher = true, -- Enable real-time filesystem watching
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = 'git_status_changed',
        handler = function()
          require('neo-tree.sources.manager').refresh('filesystem')
        end,
      },
      {
        event = 'vim_buffer_changed',
        handler = function()
          require('neo-tree.sources.manager').refresh('git_status')
        end,
      },
    },
    enable_git_status = true,
    enable_diagnostics = true,
  },
}
