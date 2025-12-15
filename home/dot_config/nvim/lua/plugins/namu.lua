return {
    "bassamsdata/namu.nvim",
    keys = {
        { "<leader>ss", "<CMD>Namu symbols<CR>",   mode = { "n" }, desc = "Jump to LSP symbol" },
        { "<leader>sw", "<CMD>Namu workspace<CR>", mode = { "n" }, desc = "Jump to LSP symbol in the workspace" },
    },
    config = function()
        require("namu").setup({
            namu_symbols = {
                enable = true,
                options = {
                    movement = {
                        next = { "<C-j>", "<DOWN>" },
                        previous = { "<C-k>", "<UP>" },
                        close = { "<ESC>" },
                        select = { "<CR>" },
                    },
                },
            },
        })
    end,
}
