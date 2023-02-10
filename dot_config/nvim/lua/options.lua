local o = vim.opt
local g = vim.g

-- Disable netrw loading
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Encoding
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- Tabs & indents
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true
o.cindent = true

-- Undo
o.undofile = true
o.undodir = vim.fn.expand('~/.cache/nvim/undodir/')

-- Disable some annoying stuff
o.swapfile = false

-- Make status bar global
o.laststatus = 3

-- Pop-up menu
o.pumheight = 15

-- Pop-up delay
o.updatetime = 250

-- Commands
o.hlsearch = false

-- Hide open buffers
o.hidden = true

-- Themes support improvement
o.termguicolors = true
o.background = 'dark'

-- UI-related
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.showbreak = '⤷ '

-- Leader
g.mapleader = ' '

