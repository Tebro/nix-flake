{ pkgs, config, lib,...}: {

  imports = [./waybar.nix];
  programs.rofi.enable = true;
  programs.hyprlock.enable = true;
  services = {
    dunst.enable = true;
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          #ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 180;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 220;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1200;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
  catppuccin = {
    sway.enable = true;
    hyprlock.enable = true;
    rofi.enable = true;
    dunst.enable = true;
    cursors.enable = true;
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

      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Shift+d" = "exec 'rofi -show drun'";
        "${modifier}+Shift+s" = "exec 'hyprshot -m region --clipboard-only'";
        "${modifier}+n" = "exec 'dunstctl history-pop'";
        "${modifier}+Shift+n" = "exec 'dunstctl close-all'";
      };

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
