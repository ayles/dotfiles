{ mylib, ... }@args:
let
  name = "ayles-pc";
in
{
  nixosConfigurations.${name} = mylib.nixosSystem {
    inherit (args) inputs mylib myvars;
    system = "x86_64-linux";
    modules = map mylib.relativeToRoot [
      "hosts/${name}"
      "modules/nixos/desktop"
    ];
    home-modules = map mylib.relativeToRoot [ "home/linux" ];
  };
}
