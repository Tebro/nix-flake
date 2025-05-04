{lib, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vimAlias = true;

        theme = {
          enable = true;
          style = "mocha";
          name = "catppuccin";
        };

        visuals = {nvim-web-devicons.enable = true;};

        statusline.lualine = {enable = true;};

        globals = {mapLeader = "space";};

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

        mini = {icons.enable = true;};

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
          mappings = {
            confirm = "<C-y>";
            next = "<C-n>";
            previous = "<C-p>";
          };
        };

        telescope = {enable = true;};

        assistant = {
          codecompanion-nvim = {
            enable = true;
            setupOpts = {
              strategies = {
                inline.adapter = "copilot";
                chat.adapter = "copilot";
              };
              adapters = lib.mkLuaInline ''
                {
                 copilot = function()
                  return require("codecompanion.adapters").extend("copilot", {
                    schema = {
                    model = {
                    default = "claude-3.7-sonnet"
                    }
                    }
                    })
                 end
                }
              '';
            };
          };
          copilot = {
            enable = true;
            cmp.enable = true;
          };
        };

        git.enable = true;

        terminal = {
          toggleterm = {
            enable = true;
            mappings.open = "<leader>tt";
            setupOpts.winbar.enabled = false;
          };
        };

        # TODO: check if this is needed
        #formatter.conform-nvim = {
        #	enable = true;
        #};

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
          markdown = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            extensions = {render-markdown-nvim.enable = true;};
          };
        };

        utility = {
          oil-nvim = {
            enable = true;
            setupOpts = {
              win_options = {
                winbar = "%#@attribute.builtin#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}";
              };
            };
          };
          surround.enable = true;
          surround.useVendoredKeybindings = false;
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

        treesitter = {enable = true;};

        keymaps = [
          # System clipboard
          {
            mode = ["n" "v"];
            key = "<leader>y";
            action = ''"+y'';
          }
          {
            mode = ["n" "v"];
            key = "<leader>p";
            action = ''"+p'';
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
          # fd esc
          {
            mode = ["i" "v"];
            key = "fd";
            action = "<Esc>";
          }
          {
            mode = "t";
            key = "fd";
            action = "<C-\\><C-n>";
          }
          # Codecompanion
          {
            mode = "n";
            key = "<C-a>";
            action = ":CodeCompanionActions<cr>";
          }
          {
            mode = "n";
            key = "<leader>cc";
            action = ":CodeCompanionChat<cr>";
          }
        ];
      };
    };
  };
}
