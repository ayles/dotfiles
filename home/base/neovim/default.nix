{ pkgs, ... }@inputs:

{
  home.packages = with pkgs; [
    fzf
    ripgrep

    neovide
  ];

  xdg.configFile."nvim".source = ./conf;

  programs.neovim = {
    enable = true;
    # TODO revert to default when commit is merged
    package = (
      pkgs.neovim-unwrapped.overrideAttrs (prev: {
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          # Commit with cool folds
          rev = "1233ac467de7504b277425988ef9be7f8d3a9626";
          sha256 = "sha256-rmlfiex8rU4uYUATdqbsP6XXLFNXbkMmO4kEIHmucxg=";
        };
      })
    );
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

        gitsigns-nvim
        indent-blankline-nvim
        kanagawa-nvim
        lualine-nvim
        noice-nvim
        nvim-lspconfig
        nvim-notify
        nvim-web-devicons
        oil-nvim
        playground
        plenary-nvim
        telescope-nvim
        telescope-ui-select-nvim
        toggleterm-nvim
        trim-nvim
      ])
      ++ [
        (pkgs.vimUtils.buildVimPlugin {
          name = "vimp";
          src = inputs.nvim-vimpeccable;
        })

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
