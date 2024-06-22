{ config, lib, ... }:
{
  # TODO impermanence?

  imports = [ ./hardware-configuration.nix ];

  networking = {
    hostName = "ayles-pc";
    networkmanager.enable = true;
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.42.02";
      sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      persistencedSha256 = lib.fakeSha256;
    };
  };

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  system.stateVersion = "23.11";
}
