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
vim.keymap.set("i", "<S-Return>", "<C-o>o")
vim.keymap.set("n", "<Leader>tn", "<cmd>setlocal nonumber!<CR>")



-- file operation
vim.keymap.set("n", "<leader>w", vim.cmd.write)

-- Plugin Mappping
-- LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- Spectre
vim.keymap.set("n", "<Leader>so", "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set("n", "<Leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set("x", "<silent><Leader>s", "<Esc>:lua require('spectre').open_visual()<CR>")
vim.keymap.set("n", "<silent><Leader>sp", "viw:lua require('spectre').open_file_search()<CR>")
-- UndoTree
vim.keymap.set("n", "<leader>gu", vim.cmd.UndotreeToggle)
-- Telescope
-- General pickers
vim.keymap.set("n", "<localleader>r", "<cmd>Telescope resume initial_mode=normal<CR>")
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
vim.keymap.set("n", "<localleader>;", "<cmd>Telescope command_history<CR>")
vim.keymap.set("n", "<localleader>/", "<cmd>Telescope search_history<CR>")

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>")
vim.keymap.set("n", "<leader>gh", "<cmd>Telescope git_stash<CR>")

-- LSP related
vim.keymap.set("n", "<localleader>dd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<localleader>di", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<localleader>dr", "<cmd>Telescope lsp_references<CR>")

-- NeoTree
vim.keymap.set("n", "<LocalLeader>e", "<cmd>Neotree filesystem left toggle dir=./<CR>")
vim.keymap.set("n", "<LocalLeader>a", "<cmd>Neotree filesystem left reveal<CR>")

-- GotoPreview
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.keymap.set("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>")
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")

-- Todo-comment
vim.keymap.set("n", "<LocalLeader>dt", "<cmd>TodoTelescope<CR>")

-- Trouble
vim.keymap.set("n", "<leader>e", "<cmd>TroubleToggle document_diagnostics<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>TroubleToggle workspace_diagnostics<CR>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>")
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>")
vim.keymap.set("n", "]t", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>")
vim.keymap.set("n", "[t", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>")
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<CR>")
