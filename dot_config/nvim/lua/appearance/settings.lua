local o = vim.opt

vim.cmd([[let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"]])
vim.cmd([[let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"]])

o.termguicolors = true
o.background = 'dark'

o.number = true
o.relativenumber = true
o.signcolumn = 'yes'

