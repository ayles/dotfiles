{ myvars, lib, ... }:

{
  imports = [
    ../common

    (import ../home.nix ../../home/ayles-wsl.nix)
  ];

  wsl.enable = true;
  wsl.defaultUser = myvars.user;

  networking.hostName = "wsl";
  system.stateVersion = "23.11";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
