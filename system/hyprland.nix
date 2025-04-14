{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  hardware.opengl = {
    package = pkgs-unstable.mesa.drivers;

    # 32bit support for steam and what not
    driSupport32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  };

  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    dunst
    swww
    kitty
    ghostty
    wl-clipboard
    networkmanagerapplet
    nwg-displays
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  fonts.packages = with pkgs; [
    nerdfonts
  ];
}
