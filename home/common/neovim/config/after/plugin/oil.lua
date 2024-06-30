-- TODO https://github.com/stevearc/oil.nvim/issues/371
require("oil").setup {
    view_options = {
        show_hidden = false,
    },
}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
