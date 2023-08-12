return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    opts = {
    },
    config = function(plugin, opts)
        require("kanagawa").setup(opts)
        vim.cmd.colorscheme "kanagawa"
    end,
}

