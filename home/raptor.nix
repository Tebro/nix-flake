{ pkgs, ... }: {
  # enabled in default
  programs.btop.package = pkgs.btop.override { rocmSupport = true; };

  home.packages = with pkgs; [ opentrack aitrack ];

  home.file = {
    ".local/bin/opentrack-launcher" = {
      executable = true;
      text = ''
        export PATH="$PATH:${pkgs.p7zip}/bin:${pkgs.opentrack}/bin"
        echo "$@" > /home/tebro/tmp/debuglauncher.log
        ${pkgs.python3}/bin/python3 /home/tebro/flake/home/scripts/opentrack-launcher/opentrack-launcher.py "$@" &>> /home/tebro/tmp/debuglauncher.log
      '';
    };
  };

}
