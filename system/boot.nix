{ pkgs, ... }: {
  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
		extraModprobeConfig = ''
			options cfg80211 ieee80211_regdom=FI
		'';
  };
}
