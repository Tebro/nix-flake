{ pkgs, ... }: {
  catppuccin.waybar.enable = true;
  programs.waybar = {
    enable = true;
    settings.main = {
      position = "top";
      reload_style_on_change = true;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "custom/dunst"
        "hyprland/language"
        "cpu"
        "memory"
        "backlight"
        "pulseaudio"
        "battery"
        "tray"
        "idle_inhibitor"
      ];

      clock = {
        tooltip = "true";
        calendar.format.today = "<span color='#b4befe'><b>{}</b></span>";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>
        '';
      };
      tray = {
        icon-size = 12;
        show-passive-items = true;
        spacing = 10;
      };
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = false;
      };
      "hyprland/language" = {
        "format-fi" = "🇫🇮";
        "format-en" = "🇺🇸";
      };
      cpu = {

        format = "🏎️ ⚡ {usage}%";
        interval = 5;
      };
      memory = {
        format = "📈 💾 📉 {percentage}%";
        interval = 5;
      };
      backlight = {
        format = "💡 {percent}%";
        interval = 1;
        scroll-step = 5;
      };
      battery = {
        format = "🔋 {capacity}%";
        interval = 5;
      };
      pulseaudio = {
        format = "🔊 {volume}%";
        scroll-step = 5;
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };
      "custom/dunst" = {
        exec = "~/.config/waybar/dunst.sh";
        on-click = "dunstctl set-paused toggle";
        restart-interval = 1;
        format = " {} ";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = " ";
          deactivated = " ";
        };
        # Minutes until automatic reset
        timeout = 60.5;
      };
    };
    style = ''
      			* {
            	font-family: "Fira Code";
            }
            #cpu, #memory, #pulseaudio, #backlight, #tray, #battery, #language, #custom-dunst, #idle_inhibitor {
              margin-right: 10px;
              margin-top: 5px;
              margin-bottom: 5px;
              border: 2px solid rgba(0, 0, 0, 0.3);
      				border-radius: 5px;
              background: rgba(10, 10, 10, 0.3);
              padding: 5px;
            }
            #language, #idle_inhibitor {
            	min-width: 25px;
            }

            #workspaces {
            	padding: 1px;
            }

            #workspaces button.active {
            	font-weight: bold;
            }
    '';
  };
}
