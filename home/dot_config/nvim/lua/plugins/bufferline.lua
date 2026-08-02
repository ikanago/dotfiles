return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
        -- bufferline derives the slant separator glyph color from Normal's
        -- background; since it's transparent ("none"), that resolves to
        -- nothing and the glyph falls back to the terminal's default
        -- foreground (white). Pin it to the colorscheme's bg explicitly.
        local bg = require("tokyonight.colors").setup({ style = "night" }).bg_dark
		require("bufferline").setup({
            options = {
                separator_style = "slant"
            },
            highlights = {
                separator = { fg = bg },
                separator_visible = { fg = bg },
                separator_selected = { fg = bg },
                tab_separator = { fg = bg },
                tab_separator_selected = { fg = bg },
            },
		})
	end,
}
