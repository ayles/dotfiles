{ myvars, ... }:

{
  imports = [
    ../common

    (import ../home.nix ../../home/ayles-wsl.nix)
  ];

  wsl.enable = true;
  wsl.defaultUser = myvars.user;

  networking.hostName = "wsl";
  system.stateVersion = "23.11";
}
