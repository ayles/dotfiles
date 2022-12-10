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

-- Enable highlight groups
o.termguicolors = true

-- Clipboard
o.clipboard = "unnamed"

-- Line numbering
o.number = true

-- Make status bar global
o.laststatus = 3

