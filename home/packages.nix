{ config, pkgs, ... }:

{
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
    (python311.withPackages (p: with p; [

    ]))

    # Nix
    nixd

    # Lua
    sumneko-lua-language-server

    # Perl
    perl

    # Tools
    curl
    git
    git-lfs
    htop
    jq
    ripgrep

    # Apps
    tdesktop
  ];
}
