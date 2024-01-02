vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup {
    window = {
        position = "float",
    },
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = true,
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
            enabled = true,
        },
    },
    default_component_configs = {
        git_status = {
            symbols = {
                -- Change type
                added     = "",
                deleted   = "",
                modified  = "",
                renamed   = "",
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            }
        }
    }
}

