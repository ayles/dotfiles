{ nixpkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    registry.nixpkgs.flake = nixpkgs;
  };
}
