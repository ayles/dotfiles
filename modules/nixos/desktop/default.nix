{ mylib, ... }:
{
  # TODO fhs (https://github.com/ryan4yin/nix-config/blob/487d410e70ed4298e45cbe9dbf80bd22c558bd6e/modules/nixos/desktop/fhs.nix)
  # TODO or nix-ld (https://github.com/Mic92/nix-ld)
  imports = (mylib.scanPaths ./.) ++ [ ../base ];
}
