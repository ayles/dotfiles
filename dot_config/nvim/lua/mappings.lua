local vimp = require('vimp')

-- Telescope
local telescope = require('telescope.builtin')
vimp.nnoremap('<leader>f', telescope.find_files)
vimp.nnoremap('<leader>b', function()
    return telescope.buffers {
        sort_mru = true,
        ignore_current_buffer = true,
    }
end)

