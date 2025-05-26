{ config
, pkgs
, lib
, inputs
, ...
}: {
  imports = [ ./user ];

  home.username = "tebro";
  home.homeDirectory = "/home/tebro";
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
  };
  home.stateVersion = "24.11";
  home.packages = with pkgs; [ liberation_ttf nodejs_20 ];

  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  # TODO: consider moving away from the global enable

  # This fixes an issue with mako extraConfig being deprecated
  catppuccin.mako.enable = false;

  programs.ghostty.enable = true;
  catppuccin.ghostty.enable = true;

  programs.alacritty.enable = true;
  catppuccin.alacritty.enable = true;

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
  catppuccin.gtk.icon.enable = true;

  programs.bat.enable = true;
  programs.git.enable = true;
  programs.neovide.enable = true;
  programs.neovide.settings = { };

  # customized for raptor in raptor.nix
  programs.btop.enable = true;

  programs.ripgrep.enable = true;
  programs.tmux.enable = true;

  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
}
