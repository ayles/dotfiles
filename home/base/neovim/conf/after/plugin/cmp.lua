local cmp = require("cmp")
local types = require("cmp.types")

cmp.setup {
    formatting = {
        format = require("lspkind").cmp_format {
            mode = 'symbol',
            before = function(entry, vim_item)
                local detail = entry:get_completion_item().detail
                if detail ~= nil then
                    vim_item.menu = string.sub(detail, 1, 30)
                end
                vim_item.abbr = string.sub(vim_item.abbr, 1, 80)
                return vim_item
            end
        },
        fields = { 'kind', 'abbr', 'menu' },
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        -- TODO https://github.com/hrsh7th/nvim-cmp/issues/1916
        ghost_text = false,
    },
    mapping = {
        ["<Tab>"] = {
            i = cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        },
        ["<S-Tab>"] = {
            i = cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        },
        ["<CR>"] = {
            i = cmp.mapping.confirm { select = false },
        },
        ["<Up>"] = {
            i = function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                fallback()
            end,
        },
        ["<Down>"] = {
            i = function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                fallback()
            end,
        },
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
}

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
})
