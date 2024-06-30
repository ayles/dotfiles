{ config, pkgs, ... }:
{
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      args = [ "--rt" ];
    };
  };

  environment.systemPackages = [
    (pkgs.lutris.override {
      buildFHSEnv = pkgs.buildFHSEnv.override { bubblewrap = "${config.security.wrapperDir}/.."; };
    })
  ];
}
