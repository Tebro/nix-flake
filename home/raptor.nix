{pkgs, ...}: {
  # enabled in default
  programs.btop.package = pkgs.btop.override {rocmSupport = true;};
}
