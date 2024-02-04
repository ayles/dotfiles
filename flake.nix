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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      user = "ayles";
    in
    {
      nixosConfigurations = {
        ayles-wsl = nixpkgs.lib.nixosSystem (
          let
            stateVersion = "23.11";
          in
          {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs user stateVersion;
              hostname = "ayles-wsl";
            };
            modules = [
              home-manager.nixosModules.home-manager
              inputs.nixos-wsl.nixosModules.default
              {
                wsl.enable = true;
                wsl.defaultUser = user;

                programs.dconf.enable = true;

                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.${user} = {
                    imports = [
                      ./home.nix
                    ];
                    home.stateVersion = stateVersion;
                  };
                };

                system.stateVersion = stateVersion;
              }
            ];
          }
        );
      };

      darwinConfigurations = {
        ayles-osx = inputs.nix-darwin.lib.darwinSystem (
          let
            stateVersion = "23.11";
          in
          {
            system = "aarch64-darwin";
            modules = [
              home-manager.darwinModules.home-manager
              {
                users.users.${user} = {
                  name = user;
                  home = "/Users/${user}";
                };

								programs.zsh.enable = true;

                security.pam.enableSudoTouchIdAuth = true;

                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.${user} = {
                    imports = [
                      ./home.nix
                    ];
                    home.stateVersion = stateVersion;
                  };
                };

                services.nix-daemon.enable = true;

                # He-he
                system.stateVersion = 4;
              }
            ];
          }
        );
      };
    };
}

