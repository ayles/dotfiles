local default_colors = require('kanagawa.colors').setup()
require('kanagawa').setup {
    globalStatus = true,
}
vim.cmd.colorscheme 'kanagawa'

