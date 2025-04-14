let
  configDir = ../config;
in {
  home.file = {
    ".config/hypr/hyprland.conf".source = "${configDir}/hypr/hyprland.conf";
  };
}
