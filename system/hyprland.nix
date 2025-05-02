{ config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    withUWSM = true;
  };

  programs.uwsm.enable = true;

  programs.nm-applet.enable = true;

  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    dunst
    swww
    kitty
    ghostty
    wl-clipboard
    networkmanagerapplet
    nwg-displays
    brightnessctl
    xdg-utils
    xdg-user-dirs
    hyprshot
    xdg-desktop-portal-gtk
    hyprpolkitagent
    hyprlandPlugins.hy3
  ];

  systemd.packages = [ pkgs.hyprpolkitagent ];
  systemd.user.services.hyprpolkitagent.wantedBy =
    [ "graphical-session.target" ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    liberation_ttf
  ];

}
