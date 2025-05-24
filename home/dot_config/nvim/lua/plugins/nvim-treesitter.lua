return {
	"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
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
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
            indent = {
                enable = true,
                disable = { "ruby" }
            }
		})
		vim.treesitter.language.register("markdown", "octo")
	end,
}
