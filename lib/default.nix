{ nixpkgs, ... }:
{
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        nixpkgs.lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") || ((path != "default.nix") && (nixpkgs.lib.strings.hasSuffix ".nix" path))
        ) (builtins.readDir path)
      )
    );
}
