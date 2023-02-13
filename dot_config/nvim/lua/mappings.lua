local vimp = require('vimp')

-- Telescope
local telescope = require('telescope.builtin')
vimp.nnoremap('<leader>f', telescope.find_files)
vimp.nnoremap('<leader>g', telescope.live_grep)
vimp.nnoremap('<leader>b', telescope.buffers)
vimp.nnoremap('<leader>e', telescope.grep_string)

-- LSP-related
vimp.nnoremap('<c-q>', vim.lsp.buf.signature_help)
vimp.inoremap('<c-q>', vim.lsp.buf.signature_help)

-- vimp.nnoremap(']D', telescope.lsp_definitions)
-- vimp.nnoremap(']R', telescope.lsp_references)
-- vimp.nnoremap(']f', vim.lsp.buf.format)
-- vimp.vnoremap(']f', vim.lsp.buf.format)
-- vimp.nnoremap(']h', vim.lsp.buf.hover)
-- vimp.nnoremap(']r', vim.lsp.buf.rename)
-- vimp.nnoremap(']d', vim.lsp.buf.declaration)
-- vimp.nnoremap(']i', vim.lsp.buf.implementation)
-- vimp.nnoremap(']t', vim.lsp.buf.type_definition)
-- vimp.nnoremap(']a', vim.lsp.buf.code_action)
-- vimp.nnoremap(']l', vim.lsp.codelens.run)

