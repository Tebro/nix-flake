{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  imports = [
    ./user
  ];
  
  home.username = "tebro";
  home.homeDirectory = "/home/tebro";
  home.stateVersion = "24.11";
}

