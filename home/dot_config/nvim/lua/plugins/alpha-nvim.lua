return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		local headerValues = {
			{
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			},
		}

		dashboard.section.header.val = headerValues[1]

		dashboard.section.header.opts = {
			hl = "Character", -- You can change "Type" to any highlight group you prefer
			position = "center",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New file", "<cmd>ene <CR>"),
			dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
			dashboard.button(
				"s",
				"  > Settings",
				":e ~/.config/nvim/_init.lua | :cd %:p:h | split . | wincmd k | pwd<CR>"
			),
			dashboard.button("y", "  > Yazi", ":Yazi<CR>"),
			dashboard.button("q", "󰩈  > Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
