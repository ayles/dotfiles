{ config, pkgs, lib, nixpkgs, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

  # https://github.com/ryan4yin/nix-config/blob/f933146a427197249ffd837f386c7b17ce282a3e/modules/nixos/base/nix.nix
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
}
