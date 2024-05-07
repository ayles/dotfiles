{ mylib, ... }@args:
let
  name = "ayles-osx";
in
{
  darwinConfigurations.${name} = mylib.darwinSystem {
    inherit (args) inputs mylib myvars;
    system = "aarch64-darwin";
    modules = map mylib.relativeToRoot [ "hosts/${name}.nix" ];
    home-modules = map mylib.relativeToRoot [ "home/darwin" ];
  };
}
