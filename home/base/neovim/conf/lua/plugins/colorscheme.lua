require("kanagawa").setup {
    overrides = function(colors)
        return {
            FloatBorder = { bg = colors.theme.ui.bg, },
        }
    end,
}
vim.cmd.colorscheme "kanagawa"
