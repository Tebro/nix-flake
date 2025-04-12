let
  userName = "tebro";
  email = "git@tebro.simplelogin.com";
in
{
    programs.git = {
        enable = true;
        userName = userName;
        userEmail = email;
    };
}
