{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (google-chrome.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebUIDarkMode --force-dark-mode";
    })
  ];
}
