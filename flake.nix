{
  description = "Tebros first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    openaws-vpn-client.url = "github:jonathanxD/openaws-vpn-client";
    #nova-chatmix.url = "path:/home/tebro/code/nova-chatmix-linux";
    nova-chatmix.url = "github:Tebro/nova-chatmix-linux?ref=feat/nix-flake";
    zed-editor.url = "github:HPsaucii/zed-editor-flake";
    zed-editor.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs = { nixpkgs, home-manager, catppuccin, nova-chatmix, nvf
    , neorg-overlay, ... }@inputs:
    let
      home-config = { extraImports ? [ ], ... }: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.tebro = {
            imports = [
              ./home
              catppuccin.homeModules.catppuccin
              nvf.homeManagerModules.default
            ] ++ extraImports;
          };
        };
      };
    in {
      nixosConfigurations.hornet = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ neorg-overlay.overlays.default ]; }
          ./hosts/hornet.nix
          (home-config { })
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.raptor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ neorg-overlay.overlays.default ]; }
          ./hosts/raptor.nix
          (home-config { extraImports = [ ./home/raptor.nix ]; })
          nova-chatmix.nixosModule
          { services.nova-chatmix.enable = true; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
