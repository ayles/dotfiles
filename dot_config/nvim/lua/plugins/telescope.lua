return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            pickers = {
                buffers = {
                    sort_mru = true,
                    mappings = {
                        n = {
                            ["d"] = "delete_buffer"
                        },
                    }
                }
            }
        },
    }
}

