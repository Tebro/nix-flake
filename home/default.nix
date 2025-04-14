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

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.hyprland.enable = true;
  catppuccin.rofi.enable = true;
  catppuccin.ghostty.enable = true;
  catppuccin.gtk.enable = true;
}
