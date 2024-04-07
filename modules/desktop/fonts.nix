{ config, pkgs, lib, ... }:
{
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      hinting = {
        style = "full";
      };
      subpixel = {
        rgba = "rgb";
      };
      defaultFonts = {
        sansSerif = [ "Inter" ];
        serif = [ "Times New Roman" ];
        monospace = [ "MesloLGS Nerd Font" ];
      };
    };

    packages = with pkgs; [
      inter
      corefonts
      noto-fonts
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };

  # TODO kmscon?
}
