{ pkgs, ... }:

{
  home.file.".clang-format".source = ./conf/clang-format;

  home.packages = with pkgs; [
    clang-tools
  ];
}
