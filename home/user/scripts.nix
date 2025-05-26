let
  scriptsDir = ../scripts;
in
{
  home.file = {
    ".config/waybar/dunst.sh".source = "${scriptsDir}/waybar-dunst.sh";
    ".local/bin/ghostty-dropdown".source = "${scriptsDir}/ghostty-dropdown.sh";
  };
}
