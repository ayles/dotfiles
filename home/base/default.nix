{ mylib, pkgs, ... }:

{
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs; [
    # Rust
    cargo
    rust-analyzer
    rustc
    rustfmt

    # CMake
    cmake-language-server

    # Python
    nodePackages.pyright
    (python311.withPackages (p: with p; [ ]))

    # Nix
    nixd
    nixfmt-rfc-style

    # Lua
    sumneko-lua-language-server

    # Perl
    perl

    # Tools
    curl
    file
    git
    git-lfs
    htop
    jq
    ripgrep

    # Apps
    google-chrome
    tdesktop
  ];

  home.stateVersion = "23.11";
}
