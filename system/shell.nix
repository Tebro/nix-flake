{pkgs, ...}: {
  environment.pathsToLink = ["share/zsh"];
  environment.systemPackages = with pkgs; [grml-zsh-config bat];
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls -F --color=auto";
      la = "ls -A -F --color=auto";
      ll = "ls -lA -F --color=auto";
      cat = "bat";
    };

    interactiveShellInit = ''
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    '';
    promptInit = ""; # otherwise it'll override the grml prompt
  };

  # Enable zsh as default for all users
  users.defaultUserShell = pkgs.zsh;
}
