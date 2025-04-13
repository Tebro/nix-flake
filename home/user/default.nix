{
  imports = [
    ./config.nix
    ./git.nix
    ./shell.nix
    ./nvf.nix
    ./rofi.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # WIP stuff, to move later
  catppuccin.enable = true;
  catppuccin.dunst.enable = true;
  catppuccin.gtk.enable = true;
  catppuccin.ghostty.enable = true;

  programs.fzf.enable = true;
}
