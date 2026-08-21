{ pkgs, ... }:

let
  scriptsDir = ../scripts;
  deltaLibraryPath = pkgs.lib.makeLibraryPath (
    with pkgs;
    [
      alsa-lib
      fontconfig
      freetype
      glib
      libGL
      libgit2
      libx11
      libxcb
      libxext
      libxkbcommon
      openssl
      sqlite
      vulkan-loader
      wayland
      zlib
      zstd
    ]
  );
in
{
  home.file = {
    ".config/waybar/dunst.sh".source = "${scriptsDir}/waybar-dunst.sh";
    # ".local/bin/dropdown-term".source = "${scriptsDir}/dropdown-term.sh";
    ".local/bin/delta" = {
      executable = true;
      force = true;
      text = ''
        #!${pkgs.runtimeShell}
        export LD_LIBRARY_PATH="${deltaLibraryPath}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
        export XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
        exec "$HOME/.local/delta.app/bin/delta" "$@"
      '';
    };
  };
}
