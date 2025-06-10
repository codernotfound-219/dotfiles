vim.opt.relativenumber = true
vim.opt.number = true

-- netrw
vim.g.netrw_winsize = 0
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.softtabstop = 4 -- 4 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- auto-indent based on current line

vim.opt.wrap = false

-- UNDO TREE BACKUPS
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search settings
vim.opt.ignorecase = true --ignore case
vim.opt.smartcase = true -- mixedcase = case-sensitive
vim.opt.incsearch = true
vim.opt.cursorline = true

-- turn on termguicolors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes" -- show sign column so text doesnt shift

-- erase those ugly '~' eob
vim.opt.fillchars:append({ eob = " " })
vim.opt.fillchars = {
  eob = " ",
}

vim.diagnostic.config({
  virtual_text = false,
  float = {
    -- header = false,
    border = "rounded",
  },
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
