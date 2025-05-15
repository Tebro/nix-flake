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
    (inputs.zed-editor.packages.x86_64-linux.zed-editor-bin.override {
      overrideVersion = "0.187.1-pre";
      overrideHash = "sha256-dGVDixRJQcWUeDuzZHY+B7sKnNJzlUXXhVM8W85YrHI=";
    })
    nixd
    nil
    rbw
    rofi-rbw-wayland
    pinentry-rofi
    evince
  ];

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
