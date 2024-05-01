{ mylib, inputs, ... }@args:
let
  name = "ayles-wsl";
in
{
  nixosConfigurations.${name} = mylib.nixosSystem {
    inherit (args) inputs mylib myvars;
    system = "x86_64-linux";
    modules = [
      inputs.nixos-wsl.nixosModules.default
    ] ++ map mylib.relativeToRoot [ "hosts/${name}.nix" ];
    home-modules = map mylib.relativeToRoot [ "home/linux" ];
  };
}
