{ config, pkgs, lib, ... }:
{
  # TODO impermanence?

  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "ayles-pc";
    networkmanager.enable = true;
  };

  hardware.opengl.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  system.stateVersion = "23.11";









  # Fix for gamescope
  # https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1523177264
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  programs.gamescope = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dunst
    fuzzel
    pavucontrol
    sway-contrib.grimshot
    wl-clipboard
  ];
}
