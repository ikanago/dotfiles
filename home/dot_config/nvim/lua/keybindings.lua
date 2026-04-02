vim.api.nvim_set_keymap("i", "jj", "<ESC><CMD>w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<CMD>bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<CMD>bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>v", "<CMD>vert sball<CR>", { noremap = true, silent = true }) -- splits all buffers

vim.api.nvim_set_keymap("n", "<A-j>", "<CMD>m .+1<CR>==", { noremap = true, silent = true })        -- move line down in normal mode
vim.api.nvim_set_keymap("n", "<A-k>", "<CMD>m .-2<CR>==", { noremap = true, silent = true })        -- move line up in normal mode
vim.api.nvim_set_keymap("v", "<A-j>", "<CMD>m '>+1<CR>gv=gv", { noremap = true, silent = true })    -- move line down in visual mode
vim.api.nvim_set_keymap("v", "<A-k>", "<CMD>m '<-2<CR>gv=gv", { noremap = true, silent = true })    -- move line up in visual mode

vim.api.nvim_set_keymap("n", "sh", "<C-w>h", { noremap = true, silent = true })                     -- move to the window left
vim.api.nvim_set_keymap("n", "sj", "<C-w>j", { noremap = true, silent = true })                     -- move to the window below
vim.api.nvim_set_keymap("n", "sk", "<C-w>k", { noremap = true, silent = true })                     -- move to the window above
vim.api.nvim_set_keymap("n", "sl", "<C-w>l", { noremap = true, silent = true })                     -- move to the window right

vim.api.nvim_set_keymap("n", "<leader>c", "<CMD>nohlsearch<CR>", { noremap = true, silent = true }) -- clear search highlights

-- treesitter textobjects
local ts_select = function(query)
	return function() require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects") end
end
local ts_move = function(fn, query)
	return function() require("nvim-treesitter-textobjects.move")[fn](query, "textobjects") end
end

vim.keymap.set({ "x", "o" }, "af", ts_select("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", ts_select("@function.inner"))
vim.keymap.set({ "x", "o" }, "ac", ts_select("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", ts_select("@class.inner"), { desc = "select inner part of a class region" })

vim.keymap.set({ "n", "x", "o" }, "]f", ts_move("goto_next_start", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "]c", ts_move("goto_next_start", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "]a", ts_move("goto_next_start", "@parameter.inner"))
vim.keymap.set({ "n", "x", "o" }, "]F", ts_move("goto_next_end", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "]C", ts_move("goto_next_end", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "]A", ts_move("goto_next_end", "@parameter.inner"))
vim.keymap.set({ "n", "x", "o" }, "[f", ts_move("goto_previous_start", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "[c", ts_move("goto_previous_start", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "[a", ts_move("goto_previous_start", "@parameter.inner"))
vim.keymap.set({ "n", "x", "o" }, "[F", ts_move("goto_previous_end", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "[C", ts_move("goto_previous_end", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "[A", ts_move("goto_previous_end", "@parameter.inner"))
