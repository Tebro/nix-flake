{
  programs.fzf.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -F --color=auto";
      la = "ls -A -F --color=auto";
      ll = "ls -lA -F --color=auto";
      g = "git";
      rebuild = "sudo nixos-rebuild --flake ~/flake switch";
      cat = "bat";
    };

    bashrcExtra = ''
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
    '';
  };
}
