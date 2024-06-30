vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    virtual_text = {
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.HINT] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.WARN] = "●",
        },
    },
}

local float_opts = { focusable = false, border = "rounded" }
local function set_handler_opts(name, handler)
    vim.lsp.handlers[name] = vim.lsp.with(handler, float_opts)
end

set_handler_opts("textDocument/hover", vim.lsp.handlers.hover)
set_handler_opts("textDocument/signatureHelp", vim.lsp.handlers.signature_help)

local function on_attach(ev)
    local opts = {
        buffer = ev.buf
    }

    local ok, tb = pcall(require, "telescope.builtin")
    if ok then
        vim.keymap.set("n", "gd", tb.lsp_definitions, opts)
        vim.keymap.set("n", "<leader>v", tb.lsp_references, opts)
    else
        vim.keymap.set("n", "gd", tb.lsp_definitions, opts)
        vim.keymap.set("n", "<leader>v", tb.lsp_references, opts)
    end

    vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float(float_opts) end, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set({ "n", "i" }, "<c-h>", vim.lsp.buf.signature_help, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
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
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath('config'),
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    --[[ cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--pch-storage=memory",
        "-j=15",
        "--log=verbose",
    }, --]]
}

lspconfig.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.nixd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        nixd = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
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
