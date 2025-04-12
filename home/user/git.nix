let
  userName = "tebro";
  email = "git@tebro.simplelogin.com";
in
{
    programs.git = {
        enable = true;
        userName = userName;
        userEmail = email;

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
		pull = {
			rebase = true;
		};
		push = {
			default = "current";
		};
		rebase = {
			autosquash = true;
			autostash = true;
		};
	};
    };
}
