local default_colors = require('kanagawa.colors').setup()
require('kanagawa').setup {
    globalStatus = true,
    colors = {
        bg = default_colors.bg_dim, 
    },
    overrides = {
        WinSeparator = {
            fg = default_colors.bg,
        },
    },
}
vim.cmd.colorscheme 'kanagawa'

