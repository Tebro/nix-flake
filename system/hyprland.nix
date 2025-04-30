{ config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    dunst
    swww
    kitty
    physlock
    ghostty
    wl-clipboard
    networkmanagerapplet
    nwg-displays
    brightnessctl
    xdg-utils
    xdg-user-dirs
    hyprshot
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    liberation_ttf
  ];

  services.physlock = {
    enable = true;
    allowAnyUser = true;
  };
}
