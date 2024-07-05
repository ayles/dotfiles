{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tree-sitter-go-template = {
      url = "github:ngalaiko/tree-sitter-go-template";
      flake = false;
    };

    tree-sitter-jinja2 = {
      url = "github:theHamsta/tree-sitter-jinja2";
      flake = false;
    };

    tree-sitter-carbon = {
      url = "github:carbon-language/carbon-lang/trunk";
      flake = false;
    };

    tree-sitter-yson = {
      url = "github:ayles/tree-sitter-yson";
      flake = false;
    };

    nvim-vimpeccable = {
      url = "github:svermeulen/vimpeccable";
      flake = false;
    };

    cmake-tools = {
      url = "github:Civitasv/cmake-tools.nvim";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      mylib = import ./lib inputs;
      myvars = {
        user = "ayles";
      };
    in
    {
      nixosConfigurations = {
        ayles-pc = lib.nixosSystem {
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/ayles-pc
          ];
          specialArgs = {
            inherit inputs mylib myvars;
          };
        };

        ayles-wsl = lib.nixosSystem {
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./hosts/ayles-wsl
          ];
          specialArgs = {
            inherit inputs mylib myvars;
          };
        };
      };

      darwinConfigurations = {
        ayles-osx = nix-darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            ./hosts/ayles-osx
          ];
          specialArgs = {
            inherit inputs mylib myvars;
          };
        };
      };

      homeConfigurations = {

      };
    };
}
