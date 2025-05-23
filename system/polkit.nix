{pkgs, ...}: {
	#NOTE: using hyprlands agent in home config instead
	#systemd = {
  #  user.services.polkit-gnome-authentication-agent-1 = {
  #    description = "polkit-gnome-authentication-agent-1";
  #    wantedBy = ["graphical-session.target"];
  #    wants = ["graphical-session.target"];
  #    after = ["graphical-session.target"];
  #    serviceConfig = {
  #      Type = "simple";
  #      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #      Restart = "on-failure";
  #      RestartSec = 1;
  #      TimeoutStopSec = 10;
  #    };
  #  };
  #  extraConfig = ''
  #    DefaultTimeoutStopSec=10s
  #  '';
  #};

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    polkit
    polkit_gnome
  ];
}
