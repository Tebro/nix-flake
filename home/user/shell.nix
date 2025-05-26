{ pkgs, ... }: {
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        cpu
      ];
    };

    zsh = {
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
  };
}
