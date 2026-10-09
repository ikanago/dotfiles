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

                -- fg_gutter is too dim for relative line numbers
                local line_nr_fg = c.dark5
                hl.LineNr = { fg = line_nr_fg }
                hl.LineNrAbove = { fg = line_nr_fg }
                hl.LineNrBelow = { fg = line_nr_fg }
            end,
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            require("tokyonight").setup(opts)
        end,
    },
}
