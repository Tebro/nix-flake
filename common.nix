{
  config,
  pkgs,
  inputs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
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
    ./system/flatpak.nix
    ./system/hyprland.nix
    ./system/certificates.nix
    ./system/gaming.nix
    ./system/shell.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    cryptsetup
    neovim
    wget
    gnumake
    jq
    gcc
    gdb
    rustc
    cargo
    go
    zig
    zls
    playerctl
    tldr
    pavucontrol
    wireplumber
    slack
    signal-desktop
    winbox4
    lua-language-server
    inputs.openaws-vpn-client.defaultPackage.x86_64-linux
    inputs.zen-browser.packages.x86_64-linux.default
    (let
      version = "0.188.1-pre";
    in
      inputs.zed-editor.packages.x86_64-linux.zed-editor-preview-bin.overrideAttrs {
        inherit version;
        src = pkgs.fetchurl {
          url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-x86_64.tar.gz";
          sha256 = "sha256-Y+SO31alHUlp0YbH3Dd2HaFU6tRdRmjyIiiRKo77QQU=";
        };
      })
    package-version-server # used by zed
    bolt-launcher
    nixd
    nil
    evince
    unzip
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.package = pkgs.kdePackages.sddm;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  environment.variables.EDITOR = "nvim";
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # sudo nix-channel update
  programs.command-not-found.enable = true;
}
