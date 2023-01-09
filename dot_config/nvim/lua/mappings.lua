local vimp = require('vimp')

-- Telescope
local telescope = require('telescope.builtin')
vimp.nnoremap('<leader>f', telescope.find_files)
vimp.nnoremap('<leader>g', telescope.live_grep)
vimp.nnoremap('<leader>b', telescope.buffers)

