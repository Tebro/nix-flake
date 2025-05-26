{ pkgs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;

      withUWSM = true;
    };

    uwsm.enable = true;

    nm-applet.enable = true;

    hyprlock.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    fuzzel
    dunst
    swww
    kitty
    ghostty
    alacritty
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

  security.pam.services.hyprlock.enable = true;
}
