return {
    "nvim-mini/mini.bufremove",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("mini.bufremove").setup()
        vim.api.nvim_create_user_command("Bufdelete", function()
            MiniBufremove.delete()
        end, { desc = "Remove buffer" })
        vim.keymap.set("n", "<leader>w", ":Bufdelete<CR>", { noremap = true, silent = true })
    end,
}
