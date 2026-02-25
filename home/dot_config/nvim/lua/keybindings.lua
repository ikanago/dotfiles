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

vim.api.nvim_set_keymap("n", "<ESC><ESC>", "<CMD>nohlsearch<CR>", { noremap = true, silent = true }) -- clear search highlights
