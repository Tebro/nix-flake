{config, ...}: {
  home.file = {
    ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/tebro/flake/home/config/zed/settings.json";
    ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "/home/tebro/flake/home/config/zed/keymap.json";
    ".config/zed/tasks.json".source = config.lib.file.mkOutOfStoreSymlink "/home/tebro/flake/home/config/zed/tasks.json";
  };
}
