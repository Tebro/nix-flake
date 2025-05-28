local function init()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			roc = { "roc" },
			ocaml = { "ocaml" },
			go = { "gofmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			zig = { "zigfmt" },
			python = { "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },

			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			markdown = { "prettier" },
			["markdown.mdx"] = { "prettier" },

			nix = { "nixfmt" },
			bash = { "shellharden" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	})

	require("lint").linters_by_ft = {
		lua = { "luacheck" },
		-- roc = { "roc" },
		go = { "golangcilint" },
		c = { "cppcheck" },
		cpp = { "cppcheck" },

		javascript = { "eslint" },
		javascriptreact = { "eslint" },
		typescript = { "eslint" },
		typescriptreact = { "eslint" },
		css = { "eslint" },
		scss = { "eslint" },
		less = { "eslint" },
		html = { "eslint" },
		json = { "eslint" },
		jsonc = { "eslint" },

		nix = { "statix" },
		bash = { "shellharden" },
		dockerfile = { "hadolint" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})

	--require("treesitter-context").setup({ multiline_threshold = 2 })
	require("nvim-treesitter.configs").setup({
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
	})

	-- This is used by neorg concealer
	vim.opt.conceallevel = 3
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.summary"] = {},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/Notes",
					},
					default_workspace = "notes",
				},
			},
		},
	})
end

return { init = init }
