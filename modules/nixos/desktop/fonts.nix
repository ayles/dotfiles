{
  config,
  pkgs,
  lib,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;

    # TODO make closer to windows
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
        monospace = [ "MesloLGS Nerd Font Mono" ];
      };
    };

    packages = with pkgs; [
      corefonts
      inter
      noto-fonts
      vistafonts
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };

  # TODO kmscon?
}
