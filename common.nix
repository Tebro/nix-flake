{
  config,
  pkgs,
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
    ./system/gaming.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
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
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
}
