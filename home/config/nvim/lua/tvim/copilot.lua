local function init()
	require("copilot").setup({
		panel = { enabled = false },
		suggestions = { enabled = true },
	})
	require("codecompanion").setup({
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {
					schema = {
						model = {
							default = "claude-3.7-sonnet",
						},
					},
				})
			end,
		},
		strategies = {
			chat = { adapter = "copilot" },
			inline = { adapter = "copilot" },
			cmd = { adapter = "copilot" },
		},
	})

	vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>")
	vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>")
	vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>")
end

return { init = init }
