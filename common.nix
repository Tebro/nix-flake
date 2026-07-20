{ pkgs, inputs, ... }: {
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  imports = [
    ./system/boot.nix
    ./system/users.nix
    ./system/time.nix
    ./system/lang.nix
    ./system/networking.nix
    ./system/nixsettings.nix
    ./system/polkit.nix
    ./system/sound.nix
    ./system/firewall.nix
    ./system/virtualisation.nix
    ./system/services.nix
    #./system/flatpak.nix
    ./system/certificates.nix
    ./system/gaming.nix
    ./system/shell.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      cryptsetup
      neovim
      wget
      gnumake
      jq
      gcc
      gdb
      cargo
      nodejs
      playerctl
      tldr
      pavucontrol
      wireplumber
      slack
      signal-desktop
      discord
      winbox4
      #lua-language-server
      #inputs.openaws-vpn-client.defaultPackage.x86_64-linux
      inputs.zen-browser.packages.x86_64-linux.default
      zed-editor
      package-version-server # used by zed
      bolt-launcher
      nixd
      nil
      evince
      unzip
      awscli2
      jq
      postgresql
    ];

    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [ "${XDG_BIN_HOME}" ];
    };

    variables.EDITOR = "nvim";
  };
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
      };
      defaultSession = "sway";
    };

    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
  security.pam.services.sddm.enableGnomeKeyring = true;
  catppuccin = {
    flavor = "mocha";
    enable = true;
    autoEnable = true;
  };

  programs = {
    thunar.enable = true;
    xfconf.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    nix-ld.enable = true;
    nm-applet.enable = true;

    neovim = {
      enable = true;
    };

    # sudo nix-channel update
    command-not-found.enable = true;
    dconf.profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      }
    ];
  };
}
