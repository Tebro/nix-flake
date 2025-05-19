{
  lib,
  pkgs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vimAlias = true;

        startPlugins = [pkgs.vimPlugins.goto-preview];

        extraPlugins = {
          goto-preview = {
            package = pkgs.vimPlugins.goto-preview;
            setup = ''
              require('goto-preview').setup {
                default_mappings = true;
              }
            '';
          };
        };

        theme = {
          enable = true;
          style = "mocha";
          name = "catppuccin";
        };

        visuals = {nvim-web-devicons.enable = true;};

        statusline.lualine = {
          enable = true;
          setupOpts = let
            winbar_cfg = {
              lualine_a = {};
              lualine_b = {};
              lualine_c = lib.mkLuaInline ''
                { {'filename', path = 1, file_status = true, shorting_target = 0, cond = function ()
                  						return vim.bo.buftype ~= 'terminal'
                  	end} }
              '';
              lualine_x = {};
              lualine_y = {};
              lualine_z = {};
            };
          in {
            winbar = winbar_cfg;
            inactive_winbar = winbar_cfg;
          };
        };

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

        mini = {
          diff.enable = true;
          icons.enable = true;
        };

        diagnostics = {
          config.virtual_text = true;
          nvim-lint = {
            enable = true;
            lint_function = lib.mkLuaInline ''
              function(buf)
                require("lint").try_lint()
              end
            '';
          };
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

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
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
              display.diff.provider = "mini_diff";
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
            lsp.server = "nixd";
            treesitter.enable = true;
            format.enable = true;
          };
          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
            extraDiagnostics = {
              enable = true;
            };
          };
          tailwind = {
            enable = true;
            lsp.enable = true;
          };
          go = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
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

        binds.whichKey.enable = true;
        binds.hardtime-nvim.enable = true;
        notify.nvim-notify.enable = true;

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
          {
            mode = "n";
            key = "<leader>Q";
            action = "vim.diagnostic.open_float";
            lua = true;
          }
          {
            mode = "n";
            key = "<leader>q";
            action = "vim.diagnostic.setqflist";
            lua = true;
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
            action = ":update<CR>";
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
