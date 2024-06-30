{ lib, inputs, ... }:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nixpkgs.config.allowUnfree = true;

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      warn-dirty = false;
      flake-registry = "";
    };

    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

    channel.enable = false;
  };
}
