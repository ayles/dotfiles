{
  nixpkgs,
  home-manager,
  nix-darwin,
  ...
}:
let
  genSpecialArgs =
    {
      inputs,
      mylib,
      myvars,
      ...
    }:
    inputs // { inherit mylib myvars; };
in
{
  relativeToRoot = nixpkgs.lib.path.append ../.;

  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        nixpkgs.lib.attrsets.filterAttrs
          (
            path: _type:
            (_type == "directory") || ((path != "default.nix") && (nixpkgs.lib.strings.hasSuffix ".nix" path))
          )
          (builtins.readDir path)
      )
    );

  nixosSystem =
    {
      system,
      modules,
      home-modules,
      inputs,
      mylib,
      myvars,
      ...
    }@args:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = genSpecialArgs args;
      modules =
        modules
        ++ (nixpkgs.lib.optionals ((nixpkgs.lib.lists.length home-modules) > 0) [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = genSpecialArgs args;
              users.${myvars.user}.imports = home-modules;
            };
          }
        ]);
    };

  darwinSystem =
    {
      system,
      modules,
      home-modules,
      inputs,
      mylib,
      myvars,
      ...
    }@args:
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = genSpecialArgs args;
      modules =
        modules
        ++ (nixpkgs.lib.optionals ((nixpkgs.lib.lists.length home-modules) > 0) [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = genSpecialArgs args;
              users.${myvars.user}.imports = home-modules;
            };
          }
        ]);
    };
}
