require("kanagawa").setup {
    overrides = function(_)
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
        }
    end,
}
vim.cmd.colorscheme "kanagawa"
