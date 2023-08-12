local on_attach = function(client, buffer)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- For capabilites
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            -- Languages
            "p00f/clangd_extensions.nvim",
            "simrat39/rust-tools.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    focusable = false,
                    border = "rounded",
                }
            )

            require("clangd_extensions").setup {
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    filetypes = { "c", "cpp", "objc", "objcpp" },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--completion-style=detailed",
                        "--header-insertion=never",
                        "--pch-storage=memory",
                        "--suggest-missing-includes",
                        "-j=15",
                    },
                },
                extensions = {
                    autoSetHints = false,
                },
            }

            lspconfig.cmake.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig.rnix.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig.pyright.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                        },
                    },
                },
            }

            lspconfig.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            require("rust-tools").setup {
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                },
                tools = {
                    inlay_hints = {
                        auto = false,
                    },
                },
            }

            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            lspconfig.lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = runtime_path,
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                },
            }
        end,
    }
}

