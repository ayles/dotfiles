module:
{
  pkgs,
  inputs,
  myvars,
  mylib,
  ...
}:
{
  imports = [
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs myvars mylib;
        };
        users.${myvars.user}.imports = [
          module
          {
            home.username = myvars.user;
            home.homeDirectory =
              if pkgs.stdenv.isDarwin then "/Users/${myvars.user}" else "/home/${myvars.user}";
          }
        ];
      };
    }
  ];
}
