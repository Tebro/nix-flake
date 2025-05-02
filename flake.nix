{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    openaws-vpn-client.url = "github:jonathanxD/openaws-vpn-client";
    #nova-chatmix.url = "path:/home/tebro/code/nova-chatmix-linux";
    nova-chatmix.url = "github:Tebro/nova-chatmix-linux?ref=feat/nix-flake";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, openaws-vpn-client
    , nova-chatmix, ... }@inputs:
    let
      home-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.tebro = {
          imports = [ ./home catppuccin.homeModules.catppuccin ];
        };
      };
    in {
      nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ catppuccin.nixosModules.catppuccin ./hosts/nixosvm.nix ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.hornet = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/hornet.nix
          home-config
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.raptor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/raptor.nix
          home-config
          nova-chatmix.nixosModule
          { services.nova-chatmix.enable = true; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
