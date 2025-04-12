{
  imports = [
	./config.nix
	./git.nix
  ];

  programs.home-manager.enable = true;	
  
  nixpkgs = {
	config = {
		allowUnfree = true;
	};
  };
}
