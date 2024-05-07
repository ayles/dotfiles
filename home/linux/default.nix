{ mylib, ... }:

{
  imports = (mylib.scanPaths ./.) ++ [ ../base ];

  home.packages = with pkgs; [
    google-chrome
    tdesktop
  ];
}
