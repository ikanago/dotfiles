return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
		require("nvim-tree").setup({
			update_focused_file = {
				enable = true,
			},
            view = {
                width = 40,
            },

            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                local function opts(desc)
                  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end
		})
	end,
}
