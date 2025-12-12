return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>e", require("oil").open, { noremap = true, silent = true, desc = "Toggle OiL" })
        require("oil").setup()
    end
}
