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

    -- Persistent sessions
    use 'tpope/vim-obsession'

    -- Usability
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    }
    use {
        'unblevable/quick-scope',
        config = function()
            vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
        end,
    }

    -- Appearance
    use 'ellisonleao/gruvbox.nvim'
    use 'rebelot/kanagawa.nvim'
    use 'projekt0n/github-nvim-theme'
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup()
        end
    }

    -- Tree explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup {
                close_if_last_window = true, 
            }
            vim.cmd([[nnoremap \ :Neotree toggle<cr>]])
        end,
    }

    -- Tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'help', 'lua', 'vim', 'c', 'cpp', 'rust' },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    }

    -- LSP related
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'p00f/clangd_extensions.nvim'
    
    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Set up packer configuration 
    if packer_bootstrap then
        require('packer').sync()
    end
end)
