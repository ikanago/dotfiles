return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
	event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("no-neck-pain").setup({
            width = 120,
            autocmds = {
                enableOnVimEnter = true,
                enableOnTabEnter = true
            }
        })
    end
}
