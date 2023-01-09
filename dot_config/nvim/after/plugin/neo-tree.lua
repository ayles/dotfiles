vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('neo-tree').setup {
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = true,
        },
        use_libuv_file_watcher = true,
        follow_current_file = true,
    },
}

