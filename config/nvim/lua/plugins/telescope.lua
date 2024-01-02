actions = require("telescope.actions")
telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
    pickers = {
        buffers = {
            sort_mru = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer"
                },
            }
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {

            }
        },
        file_browser = {
            hijack_netrw = true,
            depth = false,
        },
    },
}

telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

