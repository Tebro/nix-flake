{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    catppuccin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        catppuccin.nixosModules.catppuccin
        ./hosts/nixosvm.nix
      ];
      specialArgs = {
        inherit inputs;
      };
    };
    nixosConfigurations.hornet = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        catppuccin.nixosModules.catppuccin
        ./hosts/hornet.nix
      ];
      specialArgs = {
        inherit inputs;
      };
    };
    homeConfigurations = {
      tebro = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          catppuccin.homeModules.catppuccin
          nvf.homeManagerModules.default
          ./home
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
