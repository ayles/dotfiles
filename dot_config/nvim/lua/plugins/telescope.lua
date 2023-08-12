return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
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
                }
            }
        end,
    }
}

