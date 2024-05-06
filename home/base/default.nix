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
    psmisc
    ripgrep

    # Apps
    google-chrome
    tdesktop

    cmake
    gnumake
    clang
    libcxx
    libevdev
  ];

  home.stateVersion = "23.11";
}
