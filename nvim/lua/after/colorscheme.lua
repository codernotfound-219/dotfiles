local theme_file = os.getenv("HOME") .. "/.config/current_theme"
local f = io.open(theme_file, "r")
local theme = "catppuccin"

if f then
  theme = f:read("*l") or "catppuccin"
  f:close()
end

if theme == "poimandres" then
  vim.cmd.colorscheme "poimandres"

  -- Fix: Override LspReference highlights to be less bright (using selection bg color)
  local highlights = { "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }
  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl, { bg = "#303340" })
  end
else
  vim.cmd.colorscheme "catppuccin"
end
