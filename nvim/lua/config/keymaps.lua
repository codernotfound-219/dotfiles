vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, {desc = "Toggle netrw Explorer"})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move Selected Down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move Selected Up"})

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- DISGUSTING
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-z>", "<Nop>")

-- CLIPBOARD INTEGRATION
vim.keymap.set("n", "<leader>y", "\"+y", {desc = "Copy to clipboard"})
vim.keymap.set("v", "<leader>y", "\"+y", {desc = "Copy to clipboard"})

-- PASTING
vim.keymap.set("n", "<leader>p", "\"_dP")

-- FORMATTER
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, {desc = "Format Document"})

-- ClEAR HIGHLIGHTS
vim.keymap.set("n", "<leader>h", "<cmd>nohl<CR>", {desc = "Clear Highlights"})
