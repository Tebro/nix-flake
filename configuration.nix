# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
    ./system/sshd.nix
    ./system/hyprland.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  environment.variables.EDITOR = "nvim";

  # Enable automatic login for the user.
  #services.getty.autologinUser = "user";

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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
