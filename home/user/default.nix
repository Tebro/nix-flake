{
  imports = [
    ./config.nix
    ./git.nix
    ./shell.nix
    ./nvf.nix
    ./rofi.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
