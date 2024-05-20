-- TODO https://github.com/stevearc/oil.nvim/issues/371
require("oil").setup {

}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
