return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            on_highlights = function(hl, c)
                -- bufferline's slant separators render as white when the
                -- fill background is transparent, so keep it opaque
                hl.BufferLineFill = { bg = c.bg_dark }
            end,
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            require("tokyonight").setup(opts)
        end,
    },
}
