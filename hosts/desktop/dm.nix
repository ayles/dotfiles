{
  myvars,
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    dunst
    pavucontrol
    sway-contrib.grimshot
    wl-clipboard
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet --time --user-menu --cmd Hyprland";
        user = myvars.user;
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
