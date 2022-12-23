require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'go',
        'gomod',
        'help',
        'javascript',
        'json',
        'lua',
        'nix',
        'proto',
        'python',
        'rust',
        'toml',
        'vim',
        'yaml',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

