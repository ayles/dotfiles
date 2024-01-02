{ config, lib, pkgs, nixos-wsl, user, ... }:

{
  imports = [
    nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
}
