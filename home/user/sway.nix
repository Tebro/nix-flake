{ pkgs, ...}: {

  imports = [./waybar.nix];
  programs.rofi.enable = true;
  services = {
    dunst.enable = true;
  };
  catppuccin = {
    sway.enable = true;
    rofi.enable = true;
    dunst.enable = true;
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps

    config = {
      modifier = "Mod4";
      terminal = "kitty";
      input."*".xkb_layout = "us,fi";
      input."*".xkb_options = "grp:win_space_toggle";
      menu = "rofi -show run";

      bars = [
        { command = "waybar";}
      ];

      window = {
        titlebar = false;
      };

      gaps = {
        inner = 12;
        smartGaps = "on";
      };

      startup = [
        {command = "nm-applet";}
      ];

    };
  };
}
