{ inputs, ... }: {
  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  environment.systemPackages = [
    inputs.nix-citizen.packages.x86_64-linux.rsi-launcher
  ];
}
