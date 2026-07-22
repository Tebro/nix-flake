{ pkgs, ... }: {
  imports = [ ./user ];
  home = {

    username = "tebro";
    homeDirectory = "/home/tebro";
    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
    stateVersion = "26.05";
    packages = with pkgs; [ liberation_ttf ];
    pointerCursor.enable = true;

    file.".profile" = {
      enable = true;
      text = ''
        export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
      '';
    };
  };
  xdg = {
    enable = true;
    portal.enable = true;
    portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    portal.config = {
      common = {
        default = "gtk";
      };
    };
  };
  catppuccin = {

    flavor = "mocha";
    # TODO: consider moving away from the global enable
    enable = true;
    autoEnable = true;

    # This fixes an issue with mako extraConfig being deprecated
    mako.enable = false;
    ghostty.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    gtk.icon.enable = true;
  };
  programs = {

    ghostty.enable = true;

    alacritty.enable = true;

    kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        name = "FiraCode-Nerd-Font-Mono-Reg";
        package = pkgs.nerd-fonts.fira-code;
      };
    };

    bat.enable = true;

    git.enable = true;

    neovide.enable = true;
    neovide.settings = { };

    # customized for raptor in raptor.nix
    btop.enable = true;

    ripgrep.enable = true;

    tmux.enable = true;

    ssh.enable = true;
    ssh.enableDefaultConfig = false;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
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
