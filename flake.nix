{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
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
    #pkgs = nixpkgs.legacyPackages.${system};
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
        home-manager.nixosModules.home-manager
        ./hosts/hornet.nix

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tebro = {
            imports = [
              catppuccin.homeModules.catppuccin
              nvf.homeManagerModules.default
              ./home
            ];
          };
        }
      ];
      specialArgs = {
        inherit inputs;
      };
    };
  };
}
