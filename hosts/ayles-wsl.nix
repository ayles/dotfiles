{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  wsl.enable = true;
  wsl.defaultUser = user;

  programs.dconf.enable = true;

  networking.hostName = "wsl";
  system.stateVersion = "23.11";
}
