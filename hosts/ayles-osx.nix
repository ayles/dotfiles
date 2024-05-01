{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
  };

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
