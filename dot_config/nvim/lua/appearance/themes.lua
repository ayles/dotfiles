local M = {}

M.gruvbox = function(contrast)
    require('gruvbox').setup {
        contrast = contrast
    }
    vim.cmd.colorscheme 'gruvbox'
end

M.kanagawa = function()
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
end

M.github = function(style)
    require('github-theme').setup {
        theme_style = style
    }
end

return M

