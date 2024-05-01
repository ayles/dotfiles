{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
      name = "MesloLGS Nerd Font Mono";
    };
    shellIntegration.enableZshIntegration = true;
    extraConfig = builtins.readFile ./conf/kitty.conf;
  };
}
