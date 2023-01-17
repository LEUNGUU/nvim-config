-- Leaderkey is <space> and local Leaderkey is ,
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Navigation
vim.keymap.set("n", "<leader><leader>", "V")
vim.keymap.set("x", "<leader><leader>", "<Esc>")

vim.keymap.set("n", "gh", "g^")
vim.keymap.set("n", "gl", "g$")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Scroll
vim.keymap.set("n", "zl", "z4l")
vim.keymap.set("n", "zh", "z4h")

-- Clipboard
vim.keymap.set("n", "Y", "y$")

-- copy a word, select a word and paste it
-- you'll still get the original one
vim.keymap.set("x", "<leader>p", [["_dP]])
-- copy things to system register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Edit
vim.keymap.set("x", "<Tab>", ">gv|")
vim.keymap.set("x", "<S-Tab>", "<gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "q", vim.cmd.quit)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


-- file operation
vim.keymap.set("n", "<leader>w", vim.cmd.write)
