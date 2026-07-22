{ pkgs, ... }: {
  programs = {
		steam = {
			enable = true;
			protontricks.enable = true;
			extraPackages = [
				pkgs.gamescope
			];
			#gamescopeSession.enable = true;
		};
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    heroic
		boxflat
		protonplus
    #bottles
  ];

	services.udev.packages = [
		pkgs.boxflat
	];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH =
      "/home/tebro/.steam/root/compatibilitytools.d";
  };
}
