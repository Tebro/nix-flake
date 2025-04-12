{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vimAlias = true;

        globals = {
          mapLeader = "space";
        };
        options = {
          tabstop = 4;
          shiftwidth = 4;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
        };

        telescope.enable = true;

        git.enable = true;

        languages.nix = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          format.enable = true;
        };

        treesitter = {
          enable = true;
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>ff";
            action = "require('telescope.builtin').find_files";
            lua = true;
          }
          {
            mode = "n";
            key = "<leader>gs";
            action = ":Git<CR>";
          }
        ];
      };
    };
  };
}
