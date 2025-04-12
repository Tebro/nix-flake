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
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
          smartindent = true;
          ignorecase = true;
          smartcase = true;
          incsearch = true;
          signcolumn = "yes";
          termguicolors = true;
          scrolloff = 8;
          relativenumber = true;
        };

        diagnostics = {
          config.virtual_text = true;
          nvim-lint.enable = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          mappings = {
            codeAction = "<leader>ca";
            goToDefinition = "gd";
            renameSymbol = "<leader>rn";
          };
        };

        autocomplete.nvim-cmp = {
          enable = true;
        };

        telescope = {
          enable = true;
        };

        git.enable = true;

        languages = {
          nix = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };
          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          tailwind = {
            enable = true;
            lsp.enable = true;
          };
        };

        utility = {
          oil-nvim.enable = true;
          motion.flash-nvim = {
            enable = true;
            mappings = {
              jump = "zk";
              treesitter = "zK";
              remote = "r";
              treesitter_search = "R";
            };
          };
        };

        treesitter = {
          enable = true;
        };

        keymaps = [
          # System clipboard
          {
            mode = ["n" "v"];
            key = "<leader>y";
            action = "\"+y";
          }
          {
            mode = "n";
            key = "<leader>p";
            action = "\"+p";
          }
          # Move lines
          {
            mode = "v";
            key = "J";
            action = ">+1<CR>gv=gv";
          }
          {
            mode = "v";
            key = "K";
            action = "<-2<CR>gv=gv";
          }
          # Git
          {
            mode = "n";
            key = "<leader>gs";
            action = ":Git<CR>";
          }
          # Write util
          {
            mode = "n";
            key = "<leader>w";
            action = "vim.cmd.update";
            lua = true;
          }
          # Oil
          {
            mode = "n";
            key = "<leader>e";
            action = "function() vim.cmd.edit(vim.fn.getcwd())end";
            lua = true;
          }
          {
            mode = "n";
            key = "<leader>E";
            action = "vim.cmd.Oil";
            lua = true;
          }
          # Maintain center while scrolling
          {
            mode = "n";
            key = "<c-d>";
            action = "<c-d>zz";
          }
          {
            mode = "n";
            key = "<c-u>";
            action = "<c-u>zz";
          }
          # Clear highlights
          {
            mode = "n";
            key = "<leader><return>";
            action = ":noh<cr>";
          }
          {
            mode = "n";
            key = "<leader>tT";
            action = ":tabnew +terminal<cr>";
          }
          # Maximise window
          {
            mode = "n";
            key = "<C-W>m";
            action = "<C-W>|<C-W>_";
          }
        ];
      };
    };
  };
}
