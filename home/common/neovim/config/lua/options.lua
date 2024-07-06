vim.g.editorconfig = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undodir/")

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.pumheight = 20
vim.opt.splitright = true

-- Highligh all matches when typing, remove highlight after enter
vim.opt.hlsearch = false
local incsearch_highlight = vim.api.nvim_create_augroup("incsearch-highlight", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = [[/,\?]],
    group = incsearch_highlight,
    callback = function()
        vim.opt.hlsearch = true
    end
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = [[/,\?]],
    group = incsearch_highlight,
    callback = function()
        vim.opt.hlsearch = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.opt_local.formatoptions = {} end,
})
