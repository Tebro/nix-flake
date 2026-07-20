{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "tebro";
        email = "git@tebro.simplelogin.com";
      };

      alias = {
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
        main = "!git fetch origin && git switch -C main origin/main";
        master = "!git fetch origin && git switch -C master origin/master";
      };
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
