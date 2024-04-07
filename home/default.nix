{ config, pkgs, ... }:

{
  imports = [
    ./clang
    ./hyprland
    ./kitty
    ./neovim
    ./chrome.nix
    ./packages.nix
    ./zsh.nix
  ];
}
