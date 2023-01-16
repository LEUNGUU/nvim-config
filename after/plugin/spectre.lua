require('spectre').setup({
    mapping = {
        ['toggle_gitignore'] = {
            map = 'tg',
            cmd = '<cmd>lua require("spectre").change_options("gitignore")<CR>',
            desc = 'toggle gitignore',
        },
    },
    find_engine = {
        ['rg'] = {
            cmd = 'rg',
            args = {
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--max-columns=0',
                '--case-sensitive',
                '--hidden',
                '--no-ignore',
            },
            options = {
                ['ignore-case'] = {
                    value = '--ignore-case',
                    icon = '[I]',
                    desc = 'ignore case',
                },
                ['hidden'] = {
                    value = '--no-hidden',
                    icon = '[H]',
                    desc = 'hidden file',
                },
                ['gitignore'] = {
                    value = '--ignore',
                    icon = '[G]',
                    desc = 'gitignore',
                },
            },
        },
    },
})
vim.keymap.set("n", "<Leader>so", "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set("n", "<Leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set("x", "<silent><Leader>s", "<Esc>:lua require('spectre').open_visual()<CR>")
vim.keymap.set("n", "<silent><Leader>sp", "viw:lua require('spectre').open_file_search()<CR>")
