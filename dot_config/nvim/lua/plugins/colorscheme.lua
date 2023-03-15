return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
        contrast = nil,
        palette_overrides = {
            dark0 = "#000000",
        },
    },
    config = function(plugin, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme "gruvbox"
    end,
}

