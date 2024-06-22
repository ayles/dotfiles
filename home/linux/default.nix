{ mylib, pkgs, ... }:

{
  imports = (mylib.scanPaths ./.) ++ [ ../base ];

  home.packages = with pkgs; [
    tdesktop
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
    ];
  };
}
