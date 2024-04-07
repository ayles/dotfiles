vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup {
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

local netrw = require("neo-tree.setup.netrw")
local hijack = netrw.hijack
-- Do not focus neo-tree on dir open
netrw.hijack = function()
    local current_win = vim.api.nvim_get_current_win()
    -- print(current_win)
    local res = hijack()
    if res then
        print(vim.api.nvim_get_current_win())
        vim.api.nvim_set_current_win(current_win)
    end
    return res
end
