return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("bufferline").setup({
            options = {
                separator_style = "slant"
            }
		})
	end,
}
