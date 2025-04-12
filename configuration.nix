# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./system/boot.nix
			./system/time.nix
			./system/lang.nix
			./system/hyprland.nix
		];


	nix.settings.experimental-features = ["nix-command" "flakes"];

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.richard = {
		isNormalUser = true;
		description = "richard";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	users.users.tebro = {
		isNormalUser = true;
		description = "tebro";
		extraGroups = [ "networkmanager" ];
		packages = with pkgs; [];
	};

	security.sudo = {
		enable = true;
		extraRules = [
		{ users = ["tebro"];
			commands = [
				{command = "ALL"; options = ["NOPASSWD"];}
			];
		}
		{ users = ["richard"];
			commands = [
				{command = "ALL"; options = ["NOPASSWD"];}
			];
		}
		];
	};
	security.polkit.enable = true;

	environment.variables.EDITOR = "nvim";

	# Enable automatic login for the user.
	#services.getty.autologinUser = "richard";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	#sound.enable = true;
	#security.rtkit.enable = true;
	#services.pipewire = {
	#  enable = true;
	#  alsa.enable = true;
	#  alsa.support32Bit = true;
	#  pulse.enable = true;
	#  jack.enable = true;
	#};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		pkgs-unstable.neovim
		bat
		wget
		git
		gnumake
		gcc
		btop
		xfce.thunar
		playerctl
		tmux
	];


	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	services.dbus.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
