{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./user
  ];

  home.username = "tebro";
  home.homeDirectory = "/home/tebro";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    liberation_ttf
  ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  programs.ghostty.enable = true;
  catppuccin.ghostty.enable = true;

  gtk.enable = true;
  catppuccin.gtk.enable = true;

  programs.bat.enable = true;
  programs.git.enable = true;
  programs.neovide.enable = true;
  programs.neovide.settings = {};
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.tmux.enable = true;
}
