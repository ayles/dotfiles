{ config, pkgs, inputs, stateVersion, ... }:

{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "kek";
    };
  };

  home.packages = with pkgs; [
    (python311.withPackages (p: with p; [

    ]))

    glxinfo
    clang-tools
    cmake
    cmake-language-server
    fzf
    git
    git-lfs
    jq
    kitty
    nodePackages.pyright
    ripgrep
    rnix-lsp
    sumneko-lua-language-server

    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink ./config/kitty;

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ./config/nvim;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      lspkind-nvim
      luasnip
      nvim-cmp

      playground
      gitsigns-nvim
      indent-blankline-nvim
      kanagawa-nvim
      lualine-nvim
      neo-tree-nvim
      nvim-lspconfig
      nvim-web-devicons
      plenary-nvim
      telescope-file-browser-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vim-cmake

      (pkgs.vimUtils.buildVimPlugin {
        name = "vimp";
        src = inputs.nvim-vimpeccable;
      })

      (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ (with pkgs; [
        (tree-sitter.buildGrammar {
          language = "gotmpl";
          version = inputs.tree-sitter-go-template.rev;
          src = inputs.tree-sitter-go-template;
        })

        (tree-sitter.buildGrammar {
          language = "jinja2";
          version = inputs.tree-sitter-jinja2.rev;
          src = inputs.tree-sitter-jinja2;
        })

        (tree-sitter.buildGrammar {
          language = "carbon";
          version = inputs.tree-sitter-carbon.rev;
          src = inputs.tree-sitter-carbon;
          location = "utils/treesitter";
          generate = true;
        })

        (tree-sitter.buildGrammar {
          language = "yson";
          version = inputs.tree-sitter-yson.rev;
          src = inputs.tree-sitter-yson;
        })
      ])))
    ];
  };

  home.stateVersion = stateVersion;
}
