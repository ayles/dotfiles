{ inputs, mylib, ... }@args:
inputs.nixpkgs.lib.attrsets.foldAttrs (acc: elem: acc // elem) { } (
  map (p: import p args) (mylib.scanPaths ./.)
)
