-- General
vim.opt.guicursor = ""
vim.opt.updatetime = 50
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Vim Directories
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Tabs and Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Formatting
vim.opt.wrap = false

-- Timing
vim.opt.ttimeout = true
vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 200
