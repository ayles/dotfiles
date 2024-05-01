{
  config,
  pkgs,
  lib,
  ...
}:
{
  # TODO impermanence?

  imports = [ ./hardware-configuration.nix ];

  networking = {
    hostName = "ayles-pc";
    networkmanager.enable = true;
  };

  hardware.opengl.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  system.stateVersion = "23.11";
}
