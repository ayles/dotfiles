local vimp = require("vimp")

-- Telescope
local telescope = require("telescope.builtin")
vimp.nnoremap("<leader>f", telescope.find_files)
vimp.nnoremap("<leader>g", telescope.live_grep)
vimp.nnoremap("<leader>b", telescope.buffers)
vimp.nnoremap("<leader>e", telescope.grep_string)

-- LSP-related
vimp.nnoremap("<c-q>", vim.lsp.buf.signature_help)
vimp.inoremap("<c-q>", vim.lsp.buf.signature_help)
vimp.nnoremap("<c-f>", vim.lsp.buf.format)
vimp.vnoremap("<c-f>", vim.lsp.buf.format)

vimp.nnoremap("<c-a>", vim.lsp.buf.code_action)

vimp.nnoremap("<c-d>", telescope.lsp_definitions)
