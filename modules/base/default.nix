{ config, pkgs, lib, ... }:
{
  imports = [
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./ssh.nix
    ./user.nix
    ./vpn.nix
    ./zsh.nix
  ];
}
