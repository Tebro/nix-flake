{
  programs.git = {
    enable = true;
    userName = "tebro";
    userEmail = "git@tebro.simplelogin.com";

    aliases = {
      s = "status";
      c = "checkout";
      cam = "commit -am";
      ce = "commit --amend --no-edit";
      l = "log --oneline --all --graph --decorate";
      l1 = "log --oneline --graph --decorate";
      r = "rebase";
      ri = "rebase -i";
      f = "fetch";
      cm = "commit -m";
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { default = "current"; };
      rebase = {
        autosquash = true;
        autostash = true;
      };
    };
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
