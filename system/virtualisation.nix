{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["tebro"];

  environment.systemPackages = with pkgs; [
    docker-compose
    distrobox
  ];
}
