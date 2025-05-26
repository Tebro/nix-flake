{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    extraLuaConfig = ''
      require("tvim").init()
    '';
    extraPackages = with pkgs; [
      eslint
      nodePackages.prettier
      tree-sitter
      nixd
      nil
      nixfmt-classic
      nixpkgs-fmt
      nil
      stylua
      statix
      zls
      lua-language-server
      luajitPackages.luacheck
      bash-language-server
      tailwindcss-language-server
      #typescript-language-server
      go
    ];
    plugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "tvim";
        src = ../config/nvim;
        #doCheck = false;
        dependencies = with pkgs.vimPlugins; [
          catppuccin-nvim
          nvim-web-devicons

          fugitive

          oil-nvim
          flash-nvim
          goto-preview
          toggleterm-nvim
          plenary-nvim
          telescope-nvim
          lualine-nvim

          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          luasnip
          vim-surround
          nvim-lspconfig
          nvim-lint
          conform-nvim

          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-treesitter-context

          # AI things
          copilot-lua
          codecompanion-nvim

          typescript-tools-nvim
          tailwind-tools-nvim
          render-markdown-nvim
        ];
      })
    ];
  };
}
