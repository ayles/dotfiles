require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

local on_attach = function(client, buffer)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

-- C++
require('clangd_extensions').setup {
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        cmd = {
            'clangd',
            '--clang-tidy',
            '--completion-style=detailed',
            '--suggest-missing-includes',
            '--header-insertion=never',
            '--inlay-hints',
            '-j15',
        },
    },
    extensions = {
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this 'CursorMoved' or 'CursorMoved,CursorMovedI' but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = 'CursorHold',
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = false,
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = '-> ',
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = 'Comment',
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            role_icons = {
                type = '',
                declaration = '',
                expression = '',
                specifier = '',
                statement = '',
                ['template argument'] = '',
            },

            kind_icons = {
                Compound = '',
                Recovery = '',
                TranslationUnit = '',
                PackExpansion = '',
                TemplateTypeParm = '',
                TemplateTemplateParm = '',
                TemplateParamObject = '',
            },

            highlights = {
                detail = 'Comment',
            },
        },
        memory_usage = {
            border = 'none',
        },
        symbol_info = {
            border = 'none',
        },
    },
}

-- CMake
lspconfig.cmake.setup {
    on_attach = on_attach,
}

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    },
}

-- Rust
require('rust-tools').setup {
    on_attach = on_attach,
}
