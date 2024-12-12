return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Search Files" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Search Git Files" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor in cwd" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string in cwd 'LIVE GREP'" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
  },
}
