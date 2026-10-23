return {
    "aaronik/treewalker.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        highlight = true,
        highlight_duration = 150,
    },
    config = function()
        -- movement
        vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { silent = true })

        -- swapping
        vim.keymap.set("n", "<leader><C-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
        vim.keymap.set("n", "<leader><C-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
        vim.keymap.set("n", "<leader><C-l>", "<cmd>Treewalker SwapRight<CR>", { silent = true })
        vim.keymap.set("n", "<leader><C-h>", "<cmd>Treewalker SwapLeft<CR>", { silent = true })
    end,
}
