return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Add a new keybinding to find hidden files (doesn't change Space Space)
    {
      "<leader>fH",
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = false })
      end,
      desc = "Find Files (hidden)",
    },
  },
}
