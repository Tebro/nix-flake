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
}
