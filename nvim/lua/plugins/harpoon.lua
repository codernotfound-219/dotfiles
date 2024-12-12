return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Mark File to Harpoon",
    },
    {
      "<leader>x",
      function()
        require("harpoon"):list():remove()
      end,
      desc = "Unmark File from Harpoon",
    },
    {
      "<leader>X",
      function()
        require("harpoon"):list():clear()
      end,
      desc = "Unmark All Files from Harpoon",
    },
    {
      "<C-o>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Toggle Harpoon UI",
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon 4",
    },
    {
      "<C-f>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Harpoon Prev",
    },
    {
      "<C-e>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Harpoon Next",
    },
  },
  opts = {},

  --NOTE: Commented out due to slowness
  --[[
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc = "Mark File to Harpoon"})
    vim.keymap.set("n", "<leader>x", function() harpoon:list():remove() end, {desc = "Unmark File from Harpoon"})
    vim.keymap.set("n", "<leader>X", function() harpoon:list():clear() end, {desc = "Unmark All Files from Harpoon"})
    vim.keymap.set("n", "<C-o>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Toggle Harpoon"})

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc = "Harpoon 1"})
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc = "Harpoon 2"})
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc = "Harpoon 3"})
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc = "Harpoon 4"})

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-e>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-f>", function() harpoon:list():next() end)
  end,
  --]]
}
