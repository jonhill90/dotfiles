-- VSCode-specific Neovim configuration
-- Loaded only when running inside VSCode via vscode-neovim extension

-- Set leader key to space (consistent with LazyVim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Sync clipboard with system (so normal 'y' works with Cmd+V)
vim.opt.clipboard = "unnamedplus"

-- Helper function for VSCode actions
local vscode = require("vscode")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Exit insert mode with jj or jk (consistent with terminal config)
keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)

-- =====================================================================
-- File Navigation & Explorer
-- =====================================================================
-- <leader>e = Toggle sidebar (no focus change)
keymap({ "n", "v" }, "<leader>e", function()
  vscode.call("workbench.action.toggleSidebarVisibility")
end, opts)

-- <leader>E = Extensions
keymap({ "n", "v" }, "<leader>E", function()
  vscode.action("workbench.view.extensions")
end, opts)

-- <leader>ff = Find Files (matches LazyVim Telescope find_files)
keymap({ "n", "v" }, "<leader>ff", function()
  vscode.action("workbench.action.quickOpen")
end, opts)

-- <leader>fr = Recent Files
keymap({ "n", "v" }, "<leader>fr", function()
  vscode.action("workbench.action.openRecent")
end, opts)

-- =====================================================================
-- Search & Command Palette
-- =====================================================================
-- <leader>/ = Search in files (matches LazyVim Telescope live_grep)
keymap({ "n", "v" }, "<leader>/", function()
  vscode.action("workbench.action.findInFiles")
end, opts)

-- <leader><space> = Command Palette (common VSCode pattern)
keymap({ "n", "v" }, "<leader><space>", function()
  vscode.action("workbench.action.showCommands")
end, opts)

-- =====================================================================
-- Terminal (matches LazyVim Ctrl+/)
-- =====================================================================
-- Ctrl+/ = Toggle Terminal (matches LazyVim default - focuses terminal when opened)
keymap({ "n", "v", "t" }, "<C-/>", function()
  vscode.action("workbench.action.terminal.toggleTerminal")
end, opts)

-- <leader>tn = New Terminal
keymap({ "n", "v" }, "<leader>tn", function()
  vscode.action("workbench.action.terminal.new")
end, opts)

-- =====================================================================
-- Code Actions & LSP (matches LazyVim defaults)
-- =====================================================================
-- <leader>ca = Code Actions (LazyVim default)
keymap({ "n", "v" }, "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end, opts)

-- <leader>cr = Rename Symbol (LazyVim default)
keymap({ "n", "v" }, "<leader>cr", function()
  vscode.action("editor.action.rename")
end, opts)

-- K = Show hover (vim convention, LazyVim default)
keymap("n", "K", function()
  vscode.action("editor.action.showHover")
end, opts)

-- gd = Go to Definition (vim convention, handled by vscode-neovim)
-- gr = Go to References (vim convention, handled by vscode-neovim)
-- These work automatically, but can be explicitly mapped if needed

-- =====================================================================
-- Debugging
-- =====================================================================
-- <leader>db = Toggle Breakpoint
keymap({ "n", "v" }, "<leader>db", function()
  vscode.action("editor.debug.action.toggleBreakpoint")
end, opts)

-- <leader>dc = Debug Continue
keymap({ "n", "v" }, "<leader>dc", function()
  vscode.action("workbench.action.debug.continue")
end, opts)

-- =====================================================================
-- Buffer/Tab Navigation (matches LazyVim)
-- =====================================================================
-- Shift+h = Previous tab (matches LazyVim previous buffer)
keymap("n", "H", function()
  vscode.action("workbench.action.previousEditor")
end, opts)

-- Shift+l = Next tab (matches LazyVim next buffer)
keymap("n", "L", function()
  vscode.action("workbench.action.nextEditor")
end, opts)

-- <leader>bd = Close current tab (matches LazyVim buffer delete)
keymap({ "n", "v" }, "<leader>bd", function()
  vscode.action("workbench.action.closeActiveEditor")
end, opts)

-- =====================================================================
-- Window Management
-- =====================================================================
-- <leader>w prefix for window operations
-- <leader>ws = Split horizontal
keymap({ "n", "v" }, "<leader>ws", function()
  vscode.action("workbench.action.splitEditorDown")
end, opts)

-- <leader>wv = Split vertical
keymap({ "n", "v" }, "<leader>wv", function()
  vscode.action("workbench.action.splitEditorRight")
end, opts)

-- <leader>wc = Close editor (matches LazyVim window close)
keymap({ "n", "v" }, "<leader>wc", function()
  vscode.action("workbench.action.closeActiveEditor")
end, opts)

-- <leader>wo = Close other editors
keymap({ "n", "v" }, "<leader>wo", function()
  vscode.action("workbench.action.closeOtherEditors")
end, opts)

-- Navigate between splits with Ctrl+hjkl (matches terminal tmux navigation)
keymap("n", "<C-h>", function()
  vscode.action("workbench.action.navigateLeft")
end, opts)

keymap("n", "<C-j>", function()
  vscode.action("workbench.action.navigateDown")
end, opts)

keymap("n", "<C-k>", function()
  vscode.action("workbench.action.navigateUp")
end, opts)

keymap("n", "<C-l>", function()
  vscode.action("workbench.action.navigateRight")
end, opts)

-- =====================================================================
-- Git Integration
-- =====================================================================
-- <leader>gg = Source Control View (matches LazyVim LazyGit)
keymap({ "n", "v" }, "<leader>gg", function()
  vscode.action("workbench.view.scm")
end, opts)

-- =====================================================================
-- Visual Mode Improvements
-- =====================================================================
-- Keep selection when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected lines up/down (J/K)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- =====================================================================
-- Quality of Life
-- =====================================================================
-- Clear search highlighting
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Center screen after jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste over selection without yanking replaced text
keymap("x", "p", '"_dP', opts)
