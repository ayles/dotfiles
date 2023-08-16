function setup_directives()
    query = require("vim.treesitter.query")
    -- Expects smth like "{%%%s*()([^ ]*)()" to match 3 groups - start, match, end
    query.add_directive(
        "gmatch!",
        function(match, _, bufnr, pred, metadata)
            local node = match[pred[2]]
            if not node then
                return
            end
            text = vim.treesitter.get_node_text(node, bufnr, metadata)
            for s, match, e in text:gmatch(pred[3]) do
                local range = { node:range() }
                range[2] = range[2] + s - 1
                range[4] = range[4] + e - #text - 1
                metadata[pred[2]] = { range = range }
                break
            end
        end,
    true)

    -- Selects nth filetype from the dotted filetype, sets "text" if out of bounds
    query.add_directive(
        "set-lang-from-nth-dotted-filetype!",
        function(match, _, bufnr, pred, metadata)
            local exts = {}
            for ext in vim.bo[bufnr].filetype:gmatch("[^%.]+") do
                table.insert(exts, ext)
            end
            metadata["injection.language"] = exts[1 + pred[2]] or "text"
        end,
    true)
end

function try_set_query(lang, query_name, text)
    pcall(query.set, lang, query_name, text)
end

-- Try templater parser first. Use second extension to inherit indentations and other props
function detect_templater_filetype(path, bufnr, templater_filetype)
    filename = path:match("(.+)%..+$")
    filetype = vim.filetype.match({ filename = filename, buf = bufnr })
    return filetype and (templater_filetype .. "." .. filetype) or templater_filetype
end

function setup_gotmpl()
    require("nvim-treesitter.parsers").get_parser_configs().gotmpl = {
        install_info = {
            url = "https://github.com/ngalaiko/tree-sitter-go-template",
            files = {"src/parser.c"},
        },
        filetype = "tmpl",
    }
    vim.filetype.add({
        extension = {
            tmpl = function(path, bufnr)
                return detect_templater_filetype(path, bufnr, "gotmpl")
            end,
        },
    })
    try_set_query("gotmpl", "injections", [[
        ((text) @injection.content
            (#set! injection.combined)
            (#set-lang-from-nth-dotted-filetype! 1))
    ]])
end

function setup_jinja2()
    require("nvim-treesitter.parsers").get_parser_configs().jinja2 = {
        install_info = {
            url = "https://github.com/theHamsta/tree-sitter-jinja2",
            files = {"src/parser.c"},
        },
        filetype = "j2",
    }
    vim.filetype.add({
        extension = {
            j2 = function(path, bufnr)
                return detect_templater_filetype(path, bufnr, "jinja2")
            end,
        },
    })
    -- Plugin's AST output is kinda raw, a little hacking is required to improve highlighting
    try_set_query("jinja2", "injections", [[
        ([(jinja_stuff) (expression)] @injection.content (#set! injection.language "python"))
        ((text) @injection.content
            (#set! injection.combined)
            (#set-lang-from-nth-dotted-filetype! 1))
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

function setup_carbon()
    require("nvim-treesitter.parsers").get_parser_configs().carbon = {
        install_info = {
            url = "https://github.com/carbon-language/carbon-lang",
            files = {"src/parser.c", "src/scanner.c"},
            branch = "trunk",
            location = "utils/treesitter",
        },
        filetype = "carbon",
    }
    vim.filetype.add({
        extension = {
            carbon = "carbon",
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
                "html",
                "htmldjango",
                "javascript",
                "json",
                "lua",
                "nix",
                "nix",
                "proto",
                "python",
                "query",
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
            setup_directives()
            setup_gotmpl()
            setup_jinja2()
            setup_yaml()
            setup_carbon()
            vim.cmd("autocmd FileType python setlocal indentexpr=")
        end,
    },
    {
        "nvim-treesitter/playground",
    },
}

