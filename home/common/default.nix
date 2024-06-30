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
    htop
    jq
    lsof
    ripgrep
  ];

  home.stateVersion = "23.11";
}
