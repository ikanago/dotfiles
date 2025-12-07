return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
	event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("no-neck-pain").setup({
            autocmds = {
                enableOnVimEnter = true,
                enableOnTabEnter = true,
            },
            width = 120,
        })
    end
}
