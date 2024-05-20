{
  mylib,
  myvars,
  inputs,
  ...
}@args:
inputs.flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in
  {
    packages = {
      homeConfigurations.${myvars.user} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = map mylib.relativeToRoot [ "home/base" ] ++ [
          {
            home.username = myvars.user;
            home.homeDirectory =
              if pkgs.stdenv.isDarwin then "/Users/${myvars.user}" else "/home/${myvars.user}";
          }
        ];
        extraSpecialArgs = inputs // {
          inherit mylib myvars;
        };
      };
    };
  }
)
