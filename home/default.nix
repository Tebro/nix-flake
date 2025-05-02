{ config, pkgs, lib, inputs, ... }: {
  imports = [ ./user ];

  home.username = "tebro";
  home.homeDirectory = "/home/tebro";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [ liberation_ttf nodejs_20 ];

  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  programs.ghostty.enable = true;
  catppuccin.ghostty.enable = true;

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  catppuccin.gtk.enable = true;

  programs.bat.enable = true;
  programs.git.enable = true;
  programs.neovide.enable = true;
  programs.neovide.settings = { };
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.tmux.enable = true;
}
