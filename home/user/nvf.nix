{
	programs.nvf = {
		enable = true;
		settings = {
                        vim.vimAlias = true;
			vim.lsp = {
				enable = true;
			};
                        vim.languages.nix = {
                                enable = true;
                                lsp.enable = true;
                                treesitter.enable = true;
                        };
		};
	};
}
