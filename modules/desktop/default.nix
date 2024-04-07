{ config, pkgs, lib, ... }:
{
  imports = [
    # TODO fhs (https://github.com/ryan4yin/nix-config/blob/487d410e70ed4298e45cbe9dbf80bd22c558bd6e/modules/nixos/desktop/fhs.nix)
    # TODO or nix-ld (https://github.com/Mic92/nix-ld)
    ./audio.nix
    ./bluetooth.nix
    ./dm.nix
    ./fonts.nix
    ./network.nix
  ];
}
