return {
    "echasnovski/mini.animate",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("mini.animate").setup({
            -- Vertical scroll
            scroll = {
                enable = true,
                timing = require('mini.animate').gen_timing.exponential({ duration = 150, unit = 'total' }),
            },
        })
    end,
}
