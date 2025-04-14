{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    catppuccin.url = "github:catppuccin/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    nvf,
    catppuccin,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixosvm.nix
      ];
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
    };
    nixosConfigurations.hornet = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/hornet.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
      ];
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
    };
    homeConfigurations = {
      tebro = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nvf.homeManagerModules.default
          catppuccin.homeModules.catppuccin
          ./home
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
        };
      };
    };
  };
}
