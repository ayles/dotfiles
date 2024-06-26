local actions = require("telescope.actions")
local telescope = require("telescope")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>e", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/958#issuecomment-1753449242
        get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" then
                    return win
                end
            end
            return 0
        end,
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
        sorting_strategy = "ascending",
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
    },
}

telescope.load_extension("ui-select")
