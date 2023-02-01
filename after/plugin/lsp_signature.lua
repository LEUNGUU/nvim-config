local cfg = {
    bind = true,
    handler_opts = {
        border = "rounded"
    },
    wrap = true,
    doc_lines = 20,
    floating_window = true,
}
require "lsp_signature".setup(cfg)
