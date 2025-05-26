local function init()
	require("render-markdown").setup({})

	local cmp = require("cmp")

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
		},

		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-n'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			--['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-y>'] = cmp.mapping.confirm({ select = true }),
		}),
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},

		sources = {
			{ name = 'render-markdown' },
			{ name = 'luasnip' },
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
		},

	})

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
	})

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lspconfig = require("lspconfig")

	lspconfig.bashls.setup({capabilities = capabilities})
	lspconfig.lua_ls.setup({capabilities = capabilities})
	lspconfig.nixd.setup({capabilities = capabilities})
	lspconfig.nil_ls.setup({capabilities = capabilities})
	lspconfig.zls.setup({capabilities = capabilities})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
	vim.keymap.set('n', 'g.', vim.lsp.buf.code_action)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)
	vim.keymap.set('n', '<leader>Q', vim.diagnostic.open_float)
	vim.keymap.set('n', '<leader>lf', function()
		vim.lsp.buf.format { async = true }
	end)

	vim.diagnostic.config({
		virtual_text = true
	})

	require("typescript-tools").setup({})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.json", "*.html", "*.css", "*.scss" },
		command = "Neoformat prettier"
	})

end 
return {init = init}
