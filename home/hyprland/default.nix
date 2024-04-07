{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        # Nvidia
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,0"
      ];
    };
    extraConfig = builtins.readFile ./conf/hyprland.conf;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL";
    };
  };
}
