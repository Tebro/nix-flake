local function init()
	vim.cmd.colorscheme("catppuccin")

	require("oil").setup({})
	-- Open pwd
	vim.keymap.set('n', '<leader>e', function()
		vim.cmd.edit(vim.fn.getcwd())
	end)
	-- open dir of current file
	vim.keymap.set('n', '<leader>E', vim.cmd.Oil)

	vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

	local gotop = require('goto-preview')
	gotop.setup {
		height = 30,
		--debug = true
	}
	vim.keymap.set('n', 'gpd', gotop.goto_preview_definition, {})
	vim.keymap.set('n', 'gpi', gotop.goto_preview_implementation, {})
	vim.keymap.set('n', 'gpr', gotop.goto_preview_references, {})
	vim.keymap.set('n', 'gpt', gotop.goto_preview_type_definition, {})
	vim.keymap.set('n', 'gP', gotop.close_all_win, {})

	local flash = require("flash")
	flash.setup({})
	vim.keymap.set({ 'n', 'x', 'o' }, 'zk', flash.jump)
	vim.keymap.set({ 'n', 'x', 'o' }, 'zK', flash.treesitter)
	vim.keymap.set('o', 'r', flash.remote)
	vim.keymap.set({ 'o', 'x' }, 'R', flash.treesitter_search)

	require("telescope").setup({})
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fG', builtin.grep_string, {})
	vim.keymap.set('v', '<leader>fG', builtin.grep_string, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fr', builtin.resume, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, {})

	require("lualine").setup({
		extensions = { "fugitive", "aerial", "oil", "quickfix", "toggleterm" },
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { {'filename', path = 1, file_status = true, shorting_target = 0, cond = function ()
				return vim.bo.buftype ~= 'terminal'
			end} },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { {'filename', path = 1, file_status = true, shorting_target = 0, cond = function ()
				return vim.bo.buftype ~= 'terminal'
			end} },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		},
	})

end

return {init = init}
