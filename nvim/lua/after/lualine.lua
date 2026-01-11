local theme_file = os.getenv("HOME") .. "/.config/current_theme"
local f = io.open(theme_file, "r")
local theme = "catppuccin"

if f then
    theme = f:read("*l") or "catppuccin"
    f:close()
end

require('lualine').setup {
  options = {
    theme = theme,
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
