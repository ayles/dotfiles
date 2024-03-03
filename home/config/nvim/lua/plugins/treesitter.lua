require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
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
}

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

setup_directives()

vim.filetype.add({
    extension = {
        carbon = "carbon",
        yson = "yson",

        tmpl = function(path, bufnr)
            return detect_templater_filetype(path, bufnr, "gotmpl")
        end,

        j2 = function(path, bufnr)
            return detect_templater_filetype(path, bufnr, "jinja2")
        end,
    },
})

try_set_query("gotmpl", "injections", [[
    ((text) @injection.content
        (#set! injection.combined)
        (#set-lang-from-nth-dotted-filetype! 1))
]])

-- Plugin's AST output is kinda raw, a little hacking is required to improve highlighting
try_set_query("jinja2", "injections", [[
    ([(jinja_stuff) (expression)] @injection.content (#set! injection.language "python"))
    ((text) @injection.content
        (#set! injection.combined)
        (#set-lang-from-nth-dotted-filetype! 1))
]])
