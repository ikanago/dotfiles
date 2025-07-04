return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	config = function()
		local lsp_component = {
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				msg = ""
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						if msg ~= "" then
							msg = msg .. ", "
						end
						msg = msg .. client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#179299", gui = "bold" },
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "nightfly",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "Avante", "AvanteInput", "AvanteSelectedFiles", "NvimTree" },
					winbar = { "Avante", "AvanteInput", "AvanteSelectedFiles", "NvimTree" },
				},
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {},
				lualine_x = { lsp_component },
				lualine_y = { "filetype", { require("recorder").recordingStatus }, "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
		})
	end,
}
