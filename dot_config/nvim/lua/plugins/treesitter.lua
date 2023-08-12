function setup_gotmpl()
    require("nvim-treesitter.parsers").get_parser_configs().gotmpl = {
        install_info = {
            url = "https://github.com/ngalaiko/tree-sitter-go-template",
            files = {"src/parser.c"},
        },
        filetype = "tmpl",
    }
    local get_gotmpl_file_type = function(path)
        return vim.filetype.match({ filename = path:match("(.+)%..+$") })
    end
    vim.filetype.add({
        extension = {
            tmpl = function(path, buffer)
                -- Try gotmpl parser first. Use second extension to inherit indentations and other props
                filetype = get_gotmpl_file_type(path)
                return filetype and ("gotmpl." .. filetype) or "gotmpl"
            end,
        },
    })
    query = require("vim.treesitter.query")
    query.add_directive(
        "set-lang-from-file-extension!",
        function(match, _, bufnr, pred, metadata)
            path = vim.api.nvim_buf_get_name(bufnr)
            metadata["injection.language"] = get_gotmpl_file_type(path) or "text"
        end,
    true)
    query.set("gotmpl", "injections", [[
        ((text) @injection.content
            (#set! injection.combined)
            (#set-lang-from-file-extension! @injection.content))
    ]])
end

function setup_yaml()
    require("nvim-treesitter.parsers").get_parser_configs().yson = {
        install_info = {
            url = "https://github.com/ayles/tree-sitter-yson",
            files = {"src/parser.c"},
        },
        filetype = "yson",
    }
    vim.filetype.add({
        extension = {
            yson = "yson",
        },
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "go",
                "gomod",
                "javascript",
                "json",
                "lua",
                "nix",
                "nix",
                "proto",
                "python",
                "rust",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
                disable = {
                    "python",
                },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            },
        },
        config = function(plugin, opts)
            require("nvim-treesitter.configs").setup(opts)
            setup_gotmpl()
            setup_yaml()
            vim.cmd("autocmd FileType python setlocal indentexpr=")
        end,
    },
    {
        "nvim-treesitter/playground",
    },
}

