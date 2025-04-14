{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    catppuccin,
    ...
  } @ inputs: {
    nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        catppuccin.nixosModules.catppuccin
        ./hosts/nixosvm.nix
      ];
      specialArgs = {
        inherit inputs;
      };
    };
    nixosConfigurations.hornet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        ./hosts/hornet.nix

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tebro = {
            imports = [
              ./home
              nvf.homeManagerModules.default
              catppuccin.homeModules.catppuccin
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
