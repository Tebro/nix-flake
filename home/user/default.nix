{
  imports = [
    ./config.nix
    ./git.nix
    ./shell.nix
    ./nvf.nix
  ];

  programs.home-manager.enable = true;
}
