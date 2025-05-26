{ pkgs, ... }: {
  imports = [ ./waybar.nix ];
  programs.fuzzel = {
    enable = true;
    settings = { main = { terminal = "${pkgs.kitty}/bin/kitty -e"; }; };
  };
  services.dunst.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle = {
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
  catppuccin = {
    hyprland.enable = true;
    hyprlock.enable = true;
    fuzzel.enable = true;
    dunst.enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ pkgs.hyprlandPlugins.hy3 ];
    systemd.enable = false;

    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "kitty";
      "$fileManager" = "thunar";

      exec-once = [ "nm-applet" "waybar" ];

      env = [ "XCURSOR_SIZE,16" "HYPRCURSOR_SIZE,16" ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "hy3";
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = { new_status = "master"; };
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us,fi";
        #kb_variant =
        #kb_model =
        kb_options = "grp:win_space_toggle";
        #kb_rules =

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = { natural_scroll = false; };
      };
      gestures = { workspace_swipe = false; };
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
      "$mainMod" = "SUPER ";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, M, exec, /home/tebro/.local/bin/dropdown-term"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod SHIFT, E, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, C, exec, hyprctl reload config-only"
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen, 0"

        "$mainMod, D, exec, fuzzel"
        "$mainMod SHIFT, D, exec, fuzzel --list-executables-in-path"

        "$mainMod SHIFT, P, exec, loginctl lock-session"

        "$mainMod, g, hy3:makegroup, h"
        "$mainMod, v, hy3:makegroup, v"
        "$mainMod, w, hy3:makegroup, tab"

        "$mainMod, a, hy3:changefocus, raise"
        "$mainMod+SHIFT, a, hy3:changefocus, lower"

        "$mainMod, n, exec, dunstctl history-pop"
        "$mainMod SHIFT, n, exec, dunstctl close-all"
        "$mainMod SHIFT CTRL, n, exec, dunstctl set-paused toggle"

        "$mainMod, h, hy3:movefocus, l"
        "$mainMod, l, hy3:movefocus, r"
        "$mainMod, k, hy3:movefocus, u"
        "$mainMod, j, hy3:movefocus, d"

        "$mainMod SHIFT, h, hy3:movewindow, l"
        "$mainMod SHIFT, l, hy3:movewindow, r"
        "$mainMod SHIFT, k, hy3:movewindow, u"
        "$mainMod SHIFT, j, hy3:movewindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only"
      ];
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"
        # No opacity for waybar
        "opacity 1.0 override 1.0 override 1.0, class:waybar"
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # "Drop down terminal"
        "float, class:^(org.tebro.tdropmux)$"
        "monitor current, class:^(org.tebro.tdropmux)$"
        "size 95% 95%, class:^(org.tebro.tdropmux)$"
        "move 2.5% 2.5%, class:^(org.tebro.tdropmux)$"
      ];
    };
  };
}
