-- bootstrap lazy.nvim, LazyVim and your plugins
-- Check if running in VSCode
if vim.g.vscode then
  -- VSCode Neovim: Load minimal config with VSCode action keybindings
  require("config.vscode")
else
  -- Terminal Neovim: Load full LazyVim
  require("config.lazy")
end
