{ mylib, ... }:
{
  # TODO fhs (https://github.com/ryan4yin/nix-config/blob/487d410e70ed4298e45cbe9dbf80bd22c558bd6e/modules/nixos/desktop/fhs.nix)
  imports = mylib.scanPaths ./.;
}
