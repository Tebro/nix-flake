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
    ./system/services.nix
    ./system/flatpak.nix
    ./system/hyprland.nix
  ];
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
  ];

  environment.variables.EDITOR = "nvim";
}
