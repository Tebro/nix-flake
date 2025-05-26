local function init()
	require("tvim.settings").init()
	require("tvim.global-binds").init()
	require("tvim.ui").init()
	require("tvim.lsp").init()
	require("tvim.tools").init()
	require("tvim.copilot").init()
end

return {
	init = init
}
