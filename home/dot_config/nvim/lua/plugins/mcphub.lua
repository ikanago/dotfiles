return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
	},
	lazy = false,
	build = 'bundled_build.lua', -- Use bundled build instead of npm install
	config = function()
		require("mcphub").setup({
			-- Required options
			port = 3033, -- Port for MCP Hub server
			config = vim.fn.expand("~/.config/mcpservers.json"), -- Absolute path to config file
			use_bundled_binary = true, -- Use the bundled binary instead of npm installed one

			-- Optional options
			on_ready = function(hub)
				-- Called when hub is ready
			end,
			on_error = function(err)
				-- Called on errors
			end,
			log = {
				level = vim.log.levels.WARN,
				to_file = false,
				file_path = nil,
				prefix = "MCPHub",
			},
		})
	end,
}
