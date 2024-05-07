{
  config,
  lib,
  pkgs,
  myvars,
  ...
}:

{
  users.users.${myvars.user} = {
    name = myvars.user;
    home = "/Users/${myvars.user}";
  };

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
