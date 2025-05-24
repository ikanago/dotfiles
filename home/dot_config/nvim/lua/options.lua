-- encoding
vim.o.encoding = "utf-8"
vim.scriptencoding = "utf-8"

-- visual
vim.cmd("language en_US.UTF-8")
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.visualbell = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.listchars = "tab:>.,trail:~,lead:."
vim.o.list = true
vim.o.scrolloff = 5
vim.api.nvim_exec(
	[[
  augroup TrimWhitespace
    autocmd!
    autocmd BufWritePre * :%s/\\s\\+$//e
  augroup END
]],
	false
)
vim.o.sidescrolloff = 5
vim.o.wrap = false
vim.o.signcolumn = "yes:1"

-- dotenv filetype
vim.filetype.add({
	pattern = {
		[".env.*"] = "sh",
	},
})

-- search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true

-- manipulation
vim.g.mapleader = " "
vim.opt.clipboard:append({ "unnamedplus" })
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

vim.o.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- disable in copilot-chat
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "copilot-chat" then
			vim.opt_local.spell = false
		end
	end,
})
-- disable in txt
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.txt", "*.md" },
	callback = function()
		vim.opt_local.spell = false
		vim.opt_local.wrap = true
		vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
		vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*.txt" },
	callback = function()
		vim.opt.spell = true
	end,
})

vim.g.markdown_folding = 1
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.md",
	callback = function()
		vim.defer_fn(function()
			if vim.bo.filetype == "markdown" then
				vim.cmd("normal! zR")
			end
		end, 100)
	end,
})

