{
  nixpkgs,
  pkgs,
  lib,
  ...
}:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    registry.nixpkgs.flake = nixpkgs;
  };
}
