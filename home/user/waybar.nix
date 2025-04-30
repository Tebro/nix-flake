{pkgs, ...}: {
  catppuccin.waybar.enable = true;
  programs.waybar = {
    enable = true;
    settings.main = {
      position = "top";
      height = 5;
      reload_style_on_change = true;

      modules-left = ["hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["hyprland/language" "cpu" "memory" "backlight" "pulseaudio" "battery" "tray"];

      clock = {
        tooltip = "true";
        calendar.format.today = "<span color='#b4befe'><b>{}</b></span>";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>
        '';
      };
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = false;
      };
			"hyprland/language" = {
				"format-fi" = "fi";
				"format-en" = "us";
			};
      cpu = {
        format = "CPU {usage}%";
        interval = 5;
      };
      memory = {
        format = "RAM {percentage}%";
        interval = 5;
      };
      backlight = {
        format = "Light {percent}%";
        interval = 1;
        scroll-step = 5;
      };
      battery = {
        format = "Battery {capacity}%";
        interval = 5;
      };
      pulseaudio = {
        format = "Sound {volume}%";
        scroll-step = 5;
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };
    };
    style = ''
      #cpu, #memory, #pulseaudio, #backlight, #tray, #battery, #language {
        margin-right: 10px;
        margin-top: 5px;
        margin-bottom: 5px;
        border: 2px solid rgba(0, 0, 0, 0.3);
        background: rgba(10, 10, 10, 0.3);
        padding: 5px;
      }
			#language {
				min-width: 25px;
			}
    '';
  };
}
