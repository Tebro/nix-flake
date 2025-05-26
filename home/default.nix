{ pkgs, ... }: {
  imports = [ ./user ];
  home = {

    username = "tebro";
    homeDirectory = "/home/tebro";
    sessionVariables = { SSH_AUTH_SOCK = "/run/user/1000/ssh-agent"; };
    stateVersion = "24.11";
    packages = with pkgs; [ liberation_ttf nodejs_20 ];
  };
  xdg = {
    enable = true;
    portal.enable = true;
    portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  catppuccin = {

    flavor = "mocha";
    # TODO: consider moving away from the global enable
    enable = true;

    # This fixes an issue with mako extraConfig being deprecated
    mako.enable = false;
    ghostty.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    gtk.enable = true;
    gtk.icon.enable = true;
  };
  programs = {

    ghostty.enable = true;

    alacritty.enable = true;

    kitty.enable = true;

    bat.enable = true;

    git.enable = true;

    neovide.enable = true;
    neovide.settings = { };

    # customized for raptor in raptor.nix
    btop.enable = true;

    ripgrep.enable = true;

    tmux.enable = true;

    ssh.enable = true;
  };

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
  services.ssh-agent.enable = true;
}
