return {
	"bassamsdata/namu.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("namu").setup({
			-- Enable the modules you want
			namu_symbols = {
				enable = true,
				options = {
					movement = {
						next = { "<C-j>", "<DOWN>" }, -- Support multiple keys
						previous = { "<C-k>", "<UP>" }, -- Support multiple keys
						close = { "<ESC>" }, -- close mapping
						select = { "<CR>" }, -- select mapping
						delete_word = {}, -- delete word mapping
						clear_line = {}, -- clear line mapping
					},
				}, -- here you can configure namu
			},
			-- Optional: Enable other modules if needed
			ui_select = { enable = false }, -- vim.ui.select() wrapper
			colorscheme = {
				enable = false,
				options = {
					-- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
					persist = true, -- very efficient mechanism to Remember selected colorscheme
					write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
				},
			},
		})
		-- === Suggested Keymaps: ===
		vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
			desc = "Jump to LSP symbol",
			silent = true,
		})
		vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
			desc = "Colorscheme Picker",
			silent = true,
		})
	end,
}
