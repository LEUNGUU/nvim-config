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


-- Remap key shortcuts
-- General pickers
vim.keymap.set("n", "<localleader>r", "<cmd>Telescope resume initial_mode=normal<CR>")
vim.keymap.set("n", "<localleader>R", "<cmd>Telescope pickers<CR>")
vim.keymap.set("n", "<localleader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<localleader>g", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<localleader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<localleader>h", "<cmd>Telescope highlights<CR>")
vim.keymap.set("n", "<localleader>j", "<cmd>Telescope jumplist<CR>")
vim.keymap.set("n", "<localleader>m", "<cmd>Telescope marks<CR>")
vim.keymap.set("n", "<localleader>o", "<cmd>Telescope vim_options<CR>")
vim.keymap.set("n", "<localleader>t", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
vim.keymap.set("n", "<localleader>v", "<cmd>Telescope registers<CR>")
vim.keymap.set("n", "<localleader>u", "<cmd>Telescope spell_suggest<CR>")
vim.keymap.set("n", "<localleader>s", "<cmd>Telescope persisted<CR>")
vim.keymap.set("n", "<localleader>x", "<cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<localleader>z", "<cmd>lua require('plugins.telescope').pickers.zoxide()<CR>")
vim.keymap.set("n", "<localleader>;", "<cmd>Telescope command_history<CR>")
vim.keymap.set("n", "<localleader>/", "<cmd>Telescope search_history<CR>")

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>")
vim.keymap.set("n", "<leader>gh", "<cmd>Telescope git_stash<CR>")

-- Location-specific find files/directories
vim.keymap.set("n", "<localleader>n", "<cmd>lua require('plugins.telescope').pickers.plugin_directories()<CR>")
vim.keymap.set("n", "<localleader>w", "<cmd>ZkNotes<CR>")

-- Navigation
vim.keymap.set("n", "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua require('plugins.telescope').pickers.lsp_workspace_symbols_cursor()<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>lua require('plugins.telescope').pickers.find_files_cursor()<CR>")
vim.keymap.set("n", "<leader>gg", "<cmd>lua require('plugins.telescope').pickers.grep_string_cursor()<CR>")
vim.keymap.set("x", "<leader>gg", "<cmd>lua require('plugins.telescope').pickers.grep_string_visual()<CR>")

-- LSP related
vim.keymap.set("n", "<localleader>dd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<localleader>di", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<localleader>dr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<localleader>da", "<cmd>Telescope lsp_code_actions<CR>")
vim.keymap.set("x", "<localleader>da", ":Telescope lsp_range_code_actions<CR>")
