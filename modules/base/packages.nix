{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://github.com/NixOS/nixpkgs/issues/282983
    (linuxKernel.packagesFor (config.boot.kernelPackages.kernel.override { stdenv = gcc12Stdenv; buildPackages = pkgs.buildPackages // { stdenv = gcc12Stdenv; }; })).perf
  ];
}
