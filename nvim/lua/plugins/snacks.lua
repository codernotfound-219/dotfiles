local dashboard_sections = {
  { section = "header", },
  { section = "keys",   gap = 1, padding = 1 },
  {
    section = "startup",
    padding = 4,
  },
  function()
    local in_git = Snacks.git.get_root() ~= nil
    local cmds = {
      {
        pane = 2,
        cmd = 'cmatrix -Bu 6 -C green',
        padding = 2,
        height = 6,
      },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        cmd = "git --no-pager diff --stat -B -M -C",
        height = 10,
      },
    }
    return vim.tbl_map(function(cmd)
      return vim.tbl_extend("force", {
        section = "terminal",
        enabled = in_git,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      }, cmd)
    end, cmds)
  end,
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      sections = dashboard_sections
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    -- explorer = {
    --   enabled = true,
    --   auto_close = true,
    --   focues = "input",
    --   jump = { close = true },
    -- },
    picker = {
      sources = {
        explorer = {
          jump = { close = true },
        }
      }
    },
    quickfile = { enabled = true },
    -- statuscolumn = { enabled = true }, -- ALIGNS EVERYTHING TO THE RIGHT BY A BIT
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- { "<leader>e",  function() Snacks.explorer() end,                desc = "File Explorer" },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>R",  function() Snacks.rename.rename_file() end,      desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
    { "<leader>nd", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
  },
}
