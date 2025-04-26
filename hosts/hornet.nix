# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hornet-hardware-configuration.nix
    ../common.nix
  ];
  networking.hostName = "hornet"; # Define your hostname.

  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/1f875867-738c-4ae4-ba3f-bf27363fdead";

  powerManagement = {
    enable = true;
    powertop.enable = true;
	};

	services.power-profiles-daemon.enable = true;
	hardware.bluetooth.enable = true;

	environment.systemPackages = with pkgs; [
    powertop
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
