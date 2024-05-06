-- Disable netrw loading
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editorconfig
vim.g.editorconfig = false

-- Encoding
vim.opt.fileencoding = "utf-8"

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- We could disable indent here, but it is already overwritten by treesitter

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.fillchars = "fold:."
vim.opt.foldlevelstart = 99

-- Disable all kinds of annoying formatting
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = {}
    end,
})

-- Search highlight
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

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undodir/")

-- Make status bar global
vim.opt.laststatus = 3
-- Use only lualine mode
vim.opt.showmode = false

-- Pop-up menu
vim.opt.pumheight = 15

-- Pop-up delay
vim.opt.updatetime = 250

-- Hide open buffers
vim.opt.hidden = true

-- Themes support improvement
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.cursorline = true

-- UI-related
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.showbreak = "⤷ "

-- Leader
vim.g.mapleader = " "

-- Diagnostics
vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    virtual_text = {
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.HINT] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.WARN] = "●",
        },
    },
}

-- TODO remove after neovim 0.10
local signs = {
    Error = "●",
    Warn = "●",
    Info = "●",
    Hint = "●",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
