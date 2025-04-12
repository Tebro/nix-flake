{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tebro = {
    isNormalUser = true;
    description = "tebro";
    extraGroups = ["networkmanager"];
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = ["tebro"];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
