{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [ (toString ./wallpapers/japan-ambient.jpg) ];
      wallpaper = [ ",${toString ./wallpapers/japan-ambient.jpg}" ];
    };
  };
}
