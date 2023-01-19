-- plugin: null-ls.nvim
-- see: https://github.com/jose-elias-alvarez/null-ls.nvim
-- rafi settings

-- install formatters and linters with :Mason
-- hadolint, markdownlint, mypy, shellcheck, shellharden, shfmt, sql-formatter,
-- stylua, vint, yamllint, proselint

local builtins = require("null-ls").builtins

local function has_exec(filename)
    return function(_)
        return vim.fn.executable(filename) == 1
    end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
    -- should_attach = function(bufnr)
    -- 	return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
    -- end,

    sources = {
        -- Whitespace
        builtins.diagnostics.trail_space.with({
            disabled_filetypes = { "gitcommit" },
        }),

        -- Javascript
        builtins.diagnostics.eslint,

        -- Go
        builtins.formatting.gofmt.with({
            runtime_condition = has_exec("gofmt"),
        }),
        builtins.formatting.gofumpt.with({
            runtime_condition = has_exec("gofumpt"),
        }),
        builtins.formatting.golines.with({
            runtime_condition = has_exec("golines"),
        }),

        -- SQL
        builtins.formatting.sqlformat,

        -- Python
        builtins.formatting.black,

        -- Shell
        -- builtins.code_actions.shellcheck,
        builtins.diagnostics.shellcheck.with({
            runtime_condition = has_exec("shellcheck"),
            extra_filetypes = { "bash" },
        }),
        builtins.formatting.shfmt.with({
            runtime_condition = has_exec("shfmt"),
            extra_filetypes = { "bash" },
        }),
        builtins.formatting.shellharden.with({
            runtime_condition = has_exec("shellharden"),
            extra_filetypes = { "bash" },
        }),

        -- Docker
        builtins.diagnostics.hadolint.with({
            runtime_condition = has_exec("hadolint"),
        }),

        -- Markdown
        builtins.diagnostics.markdownlint.with({
            runtime_condition = has_exec("markdownlint"),
            extra_filetypes = { "vimwiki" },
        }),
        builtins.diagnostics.proselint.with({
            runtime_condition = has_exec("proselint"),
            extra_filetypes = { "vimwiki" },
        }),
    },
})
