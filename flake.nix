{
	description = "Tebros first flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		#home-manager.url = "github:nix-community/home-manager/release-24.11";
		#home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
		in 
			{


			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					./configuration.nix
				];
				specialArgs = {
					inherit pkgs;
					inherit pkgs-unstable;
				};
			};

		};
}
