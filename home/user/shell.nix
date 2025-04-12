{
	programs.bash = {
		enable = true;
		shellAliases = {
			ls = "ls -F --color=auto";
			la = "ls -A -F --color=auto";
			ll = "ls -lA -F --color=auto";
			g = "git";
			rebuild = "sudo nixos-rebuild --flake ~/flake switch";
			hm = "home-manager --flake ~/flake switch -b backup";
			full = "rebuild && hm";
		};
	};

}
