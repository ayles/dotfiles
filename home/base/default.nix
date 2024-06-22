{ mylib, pkgs, ... }:

{
  imports = mylib.scanPaths ./.;

  home.packages =
    with pkgs;
    [
      # Rust
      cargo
      rust-analyzer
      rustc
      rustfmt

      # CMake
      cmake-language-server

      # Python
      pyright
      (python311.withPackages (p: with p; [ ]))

      # Nix
      nixd
      nixfmt-rfc-style

      # Lua
      sumneko-lua-language-server

      # Perl
      perl

      # Go
      go

      # Tools
      curl
      file
      git
      git-lfs
      htop
      jq
      lsof
      ripgrep

      eternal-terminal
    ]
    ++ lib.optionals stdenv.isLinux [
      glibcLocales
    ];

  home.stateVersion = "23.11";
}
