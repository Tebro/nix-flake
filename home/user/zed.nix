{config, ...}: {
  # TODO: Enable zed with a overriden package for preview
  # Or maybe a binary package from a flake...
  home.file = {
    ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/tebro/flake/home/config/zed/settings.json";
    ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "/home/tebro/flake/home/config/zed/keymap.json";
  };
}
