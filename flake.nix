{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Why?
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    oldnixpkgs.url = "github:NixOS/nixpkgs?rev=cc3d2295b642f3d61faaa7335f79e63b5d10996e";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "oldnixpkgs";
    };

    srvos = {
      url = "github:numtide/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        stable.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    infra = {
      url = "github:nixos/infra";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };
    ofborg = {
      url = "github:NixOS/ofborg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ofborg-viewer = {
      url = "github:NixOS/ofborg-viewer";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      imports = [
        ./non-critical-infra/flake-module.nix
        ./macs/flake-module.nix
      ];
    };
}
