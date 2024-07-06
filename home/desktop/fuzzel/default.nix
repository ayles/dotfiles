{ pkgs, ... }:

{
  xdg.configFile."fuzzel" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [ fuzzel ];
}
