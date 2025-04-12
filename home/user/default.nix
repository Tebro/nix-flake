{
	imports = [
		./config.nix
		./git.nix
		./shell.nix
	];

  programs.home-manager.enable = true;	
  
  nixpkgs = {
	config = {
		allowUnfree = true;
	};
  };
}
