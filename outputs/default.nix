{ ... }@inputs:
let
  myvars = {
    user = "ayles";
  };

  mylib = import ../lib inputs;
in
import ./configurations { inherit inputs myvars mylib; } // { }
