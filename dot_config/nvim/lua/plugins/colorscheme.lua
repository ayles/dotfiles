return {
    "rebelot/kanagawa.nvim",
    opts = {

    },
    config = function(plugin, opts)
        require("kanagawa").setup(opts)
        vim.cmd.colorscheme "kanagawa"
    end,
}

