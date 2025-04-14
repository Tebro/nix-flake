{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
