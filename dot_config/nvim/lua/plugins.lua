local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer itself
    use 'wbthomason/packer.nvim'

    -- Appearance
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            local default_colors = require("kanagawa.colors").setup()
            require('kanagawa').setup({
                globalStatus = true,
                colors = {
                    bg = default_colors.bg_dim, 
                },
                overrides = {
                    WinSeparator = {
                        fg = default_colors.bg,
                    },
                },
            })
            vim.cmd.colorscheme "kanagawa"
        end,
    }
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup()
        end
    }

    -- Tree explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly', -- optional, updated every week. (see issue #1193)
        config = function()
            require("nvim-tree").setup()

            -- Auto close stuff
            -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#beauwilliams
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
                pattern = "NvimTree_*",
                callback = function()
                    local layout = vim.api.nvim_call_function("winlayout", {})
                    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
                end
            })
        end,
    }

    -- Tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "help", "vim", "c", "cpp", "rust" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    }

    -- Set up packer configuration 
    if packer_bootstrap then
        require('packer').sync()
    end
end)
