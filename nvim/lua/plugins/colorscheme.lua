return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        show_end_of_buffer = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.20,
        },
      })
    end
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        disable_background = true,
      })
    end,
  }
}

--[[
return {
  "folke/tokyonight.nvim",
  lazy=false,
  priority=1000,
  opts = {
    style = "night",
    transparent = true,
  },
  init = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}
--]]
