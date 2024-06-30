{ pkgs, ... }:
{
  home.packages = with pkgs; [ git-lfs ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "selya.main@gmail.com";
    userName = "ayles";
  };
}
