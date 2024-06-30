{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    fzf
    ripgrep
  ];

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins =
      (with pkgs.vimPlugins; [
        cmp-cmdline
        cmp-nvim-lsp
        cmp-path
        cmp_luasnip
        lspkind-nvim
        luasnip
        nvim-cmp

        kanagawa-nvim
        lualine-nvim
        nvim-lspconfig
        nvim-web-devicons
        oil-nvim
        playground
        telescope-nvim
        telescope-ui-select-nvim
        trim-nvim
      ])
      ++ [
        (pkgs.vimUtils.buildVimPlugin {
          name = "cmake-tools";
          src = inputs.cmake-tools;
        })

        (pkgs.vimPlugins.nvim-treesitter.withPlugins (
          _:
          pkgs.vimPlugins.nvim-treesitter.allGrammars
          ++ [
            (pkgs.tree-sitter.buildGrammar {
              language = "gotmpl";
              version = inputs.tree-sitter-go-template.rev;
              src = inputs.tree-sitter-go-template;
            })

            (pkgs.tree-sitter.buildGrammar {
              language = "jinja2";
              version = inputs.tree-sitter-jinja2.rev;
              src = inputs.tree-sitter-jinja2;
            })

            (pkgs.tree-sitter.buildGrammar {
              language = "carbon";
              version = inputs.tree-sitter-carbon.rev;
              src = inputs.tree-sitter-carbon;
              location = "utils/treesitter";
              generate = true;
            })

            (pkgs.tree-sitter.buildGrammar {
              language = "yson";
              version = inputs.tree-sitter-yson.rev;
              src = inputs.tree-sitter-yson;
            })
          ]
        ))
      ];
  };
}
