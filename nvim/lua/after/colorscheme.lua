local theme_file = os.getenv("HOME") .. "/.config/current_theme"
local f = io.open(theme_file, "r")
local theme = "catppuccin"

if f then
    theme = f:read("*l") or "catppuccin"
    f:close()
end

if theme == "poimandres" then
    vim.cmd.colorscheme "poimandres"
else
    vim.cmd.colorscheme "catppuccin"
end
