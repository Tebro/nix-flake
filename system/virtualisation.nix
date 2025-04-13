{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    #docker.rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #};
  };

  environment.systemPackages = with pkgs; [
    #dive
    #podman-tui
    docker-compose
  ];
}
