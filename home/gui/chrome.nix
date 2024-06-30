{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [ "--force-device-scale-factor=1.25" ];
  };
}
