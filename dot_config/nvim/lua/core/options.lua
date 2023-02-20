-- Disable netrw loading
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Tabs & indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.cindent = true

-- Disable all kinds of annoying formatting
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = {}
    end,
})

-- Remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undodir/")

-- Make status bar global
vim.opt.laststatus = 3

-- Pop-up menu
vim.opt.pumheight = 15

-- Pop-up delay
vim.opt.updatetime = 250

-- Commands
vim.opt.hlsearch = false

-- Hide open buffers
vim.opt.hidden = true

-- Themes support improvement
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- UI-related
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.showbreak = "⤷ "

-- Leader
vim.g.mapleader = " "

