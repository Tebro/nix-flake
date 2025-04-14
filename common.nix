{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
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
  ];

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs-unstable.neovim
    neovide
    bat
    wget
    git
    gnumake
    gcc
    btop
    ripgrep
    xfce.thunar
    playerctl
    tmux
    home-manager
    tldr
    discord
    pavucontrol
    wireplumber
    slack
  ];

  environment.variables.EDITOR = "nvim";
}
