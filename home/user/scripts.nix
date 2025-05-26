let
  scriptsDir = ../scripts;
in
{
  home.file = {
    ".config/waybar/dunst.sh".source = "${scriptsDir}/waybar-dunst.sh";
    ".local/bin/dropdown-term".source = "${scriptsDir}/dropdown-term.sh";
  };
}
