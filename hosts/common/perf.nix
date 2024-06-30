{ config, pkgs, ... }:
{
  environment.systemPackages = [
    # https://github.com/NixOS/nixpkgs/issues/282983
    (pkgs.linuxKernel.packagesFor (
      config.boot.kernelPackages.kernel.override {
        stdenv = pkgs.gcc12Stdenv;
        buildPackages = pkgs.buildPackages // {
          stdenv = pkgs.gcc12Stdenv;
        };
      }
    )).perf
  ];
}
