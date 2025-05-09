{
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild --flake ~/flake switch";
      g = "git";
    };
    enableCompletion = true;

    #oh-my-zsh = {
    #	enable = true;
    #	theme = "robbyrussell";
    #	plugins = [
    #		"git"
    #		"sudo"
    #	];
    #};
    #bashrcExtra = ''
    #  if command -v fzf-share >/dev/null; then
    #    source "$(fzf-share)/key-bindings.bash"
    #    source "$(fzf-share)/completion.bash"
    #  fi
    #'';
  };
}
