return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function(plugin)
            actions = require("telescope.actions")
            require("telescope").setup {
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
                    }
                },
            }
            require("telescope").load_extension("ui-select")
        end,
    }
}

