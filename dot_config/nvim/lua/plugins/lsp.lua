local on_attach = function(client, buffer)

end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Server installation
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- For capabilites
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            -- Languages
            "p00f/clangd_extensions.nvim",
            "simrat39/rust-tools.nvim",
        },
        config = function()
            vim.diagnostic.config {
                update_in_insert = true,
                severity_sort = true,
                virtual_text = {
                    prefix = "●",
                },
            }

            local signs = {
                Error = "●",
                Warn = "●",
                Info = "●",
                Hint = "●",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
            end

            require("mason").setup()
            require("mason-lspconfig").setup()

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

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

            require("rust-tools").setup {
                on_attach = on_attach,
                capabilities = capabilities,
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

--[[
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
]]

