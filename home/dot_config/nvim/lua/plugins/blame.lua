return {
    "FabijanZulj/blame.nvim",
    keys = {
        { "<leader>gb", "<cmd>BlameToggle<CR>", desc = "Blame Toggle" }
    },
    config = function()
        require("blame").setup({
            date_format = "%d.%m.%Y",
            views = {
                window = window_view,
                virtual = virtual_view,
                default = window_view,
            },
            mappings = {
                commit_info = "i",
                stack_push = "<TAB>",
                stack_pop = "<BS>",
                show_commit = "<CR>",
                close = { "<esc>", "q" },
            },
        })
    end,
}
