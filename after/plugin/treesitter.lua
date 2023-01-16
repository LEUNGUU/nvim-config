-- plugin: nvim-treesitter
-- see: https://github.com/nvim-treesitter/nvim-treesitter

-- Setup extra parsers.
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.http = {
    filetype = 'http',
    install_info = {
        url = 'https://github.com/rest-nvim/tree-sitter-http',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

-- Setup treesitter
require('nvim-treesitter.configs').setup({
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    ensure_installed = {
        'bash', 'cmake', 'comment', 'commonlisp', 'css',
        'diff', 'dockerfile', 'fish', 'gitattributes', 'gitignore',
        'go', 'gomod', 'gowork', 'graphql', 'hack', 'hcl', 'help',
        'html', 'http', 'java', 'javascript', 'jsdoc', 'json', 'json5',
        'jsonc', 'jsonnet', 'julia', 'lua', 'make', 'markdown', 'markdown_inline',
        'ninja', 'nix', 'perl', 'php', 'python', 'query', 'r', 'regex', 'rst',
        'ruby', 'rust', 'scala', 'scheme', 'scss', 'sql', 'swift', 'todotxt', 'toml',
        'typescript', 'vim', 'vue', 'yaml'
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },

    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
    },

})
