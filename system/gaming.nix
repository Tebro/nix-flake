{ pkgs, ...}:
{
	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;

	environment.systemPackages = with pkgs; [
		mangohud
		protonup
		lutris
		heroic
		bottles
	];

	environment.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/tebro/.steam/root/compatibilitytools.d";
	};
}
