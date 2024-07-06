require("kanagawa").setup {
    overrides = function(_)
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
        }
    end,

    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    }
}
vim.cmd.colorscheme "kanagawa"
