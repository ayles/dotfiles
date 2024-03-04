local vimp = require("vimp")

if vim.g.neovide then
    vim.opt.guifont = "MesloLGS Nerd Font Mono:h11"

    local copy = "<C-S-c>"
    local paste = "<C-S-v>"
    local mod = "C"

    if vim.uv.os_uname().sysname == "Darwin" then
        copy = "<D-c>"
        paste = "<D-v>"
        mod = "D"
    end

    vimp.vnoremap(copy, '"+y')
    vimp.nnoremap(paste, '"+p')
    vimp.vnoremap(paste, '"+p')
    vimp.inoremap(paste, '<ESC>"+pa')
    vimp.cnoremap(paste, '<C-R>+')

    vimp.nnoremap(string.format("<%s-=>", mod), function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.25 end)
    vimp.nnoremap(string.format("<%s-->", mod), function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.25 end)
    vimp.nnoremap(string.format("<%s-0>", mod), function() vim.g.neovide_scale_factor = 1.0 end)

    vim.g.neovide_transparency = 0.9
    vim.g.neovide_scroll_animation_length = 0.1
end
