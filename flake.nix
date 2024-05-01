{
  description = "System config";

  outputs = inputs: import ./outputs inputs;

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
}
