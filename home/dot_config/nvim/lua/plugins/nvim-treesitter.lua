return {
	"nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
			    "go",
			    "gomod",
			    "lua",
			    "python",
			    "query",
                "ruby",
                "rust",
			    "vim",
			    "vimdoc",
			},
			auto_install = true,
		})
		vim.treesitter.language.register("markdown", "octo")
	end,
}
