return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})
	end,
}
