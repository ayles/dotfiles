return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                use_libuv_file_watcher = true,
                follow_current_file = true,
            },
        },
        config = function(plugin, opts)
            vim.g.neo_tree_remove_legacy_commands = 1
            require("neo-tree").setup(opts)
        end,
    }
}

