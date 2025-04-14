{pkgs, ...}: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  environment.systemPackages = with pkgs; [
    powertop
  ];
}
