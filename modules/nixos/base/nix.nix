{
  lib,
  nixpkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };

    # https://github.com/ryan4yin/nix-config/blob/f933146a427197249ffd837f386c7b17ce282a3e/modules/nixos/base/nix.nix
    registry.nixpkgs.flake = nixpkgs;
    channel.enable = false;
  };
}
