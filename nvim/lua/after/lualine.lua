require('lualine').setup {
  options = {
    { theme = 'catppuccin' },
  },
  sections = {
    lualine_x = {
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#89b4fa" },
      },
      { 'filetype' },
    },
  },
}
