return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "isak102/telescope-git-file-history.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            'nvim-telescope/telescope-ui-select.nvim',
            dependencies = {
                "tpope/vim-fugitive",
            },
        }
    },
    event = { "VimEnter" },
    config = function()
        local actions = require("telescope.actions")

        local function multiopen(prompt_bufnr, method)
            local edit_file_cmd_map = {
                vertical = "vsplit",
                horizontal = "split",
                tab = "tabedit",
                default = "edit",
            }
            local edit_buf_cmd_map = {
                vertical = "vert sbuffer",
                horizontal = "sbuffer",
                tab = "tab sbuffer",
                default = "buffer",
            }
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local multi_selection = picker:get_multi_selection()

            if #multi_selection > 1 then
                require("telescope.pickers").on_close_prompt(prompt_bufnr)
                pcall(vim.api.nvim_set_current_win, picker.original_win_id)

                for i, entry in ipairs(multi_selection) do
                    local filename, row, col

                    if entry.path or entry.filename then
                        filename = entry.path or entry.filename

                        row = entry.row or entry.lnum
                        col = vim.F.if_nil(entry.col, 1)
                    elseif not entry.bufnr then
                        local value = entry.value
                        if not value then
                            return
                        end

                        if type(value) == "table" then
                            value = entry.display
                        end

                        local sections = vim.split(value, ":")

                        filename = sections[1]
                        row = tonumber(sections[2])
                        col = tonumber(sections[3])
                    end

                    local entry_bufnr = entry.bufnr

                    if entry_bufnr then
                        if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                            vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                        end
                        local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                        pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
                    else
                        local command = i == 1 and "edit" or edit_file_cmd_map[method]
                        if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                            filename =
                                require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                            pcall(vim.cmd, string.format("%s %s", command, filename))
                        end
                    end

                    if row and col then
                        pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
                    end
                end
            else
                actions["select_" .. method](prompt_bufnr)
            end
        end

        local telescope = require("telescope")
        local gfh_actions = require("telescope").extensions.git_file_history.actions

        telescope.setup({
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
            defaults = {
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                },
                mappings = {
                    i = {
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<CR>"] = function(prompt_bufnr)
                            multiopen(prompt_bufnr, "default")
                        end,
                        ["<C-v>"] = function(prompt_bufnr)
                            multiopen(prompt_bufnr, "vertical")
                        end,
                    },
                    n = {
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["jj"] = require("telescope.actions").close,
                        ["<CR>"] = function(prompt_bufnr)
                            multiopen(prompt_bufnr, "default")
                        end,
                        ["<C-v>"] = function(prompt_bufnr)
                            multiopen(prompt_bufnr, "vertical")
                        end,
                    },
                },
            },
            extensions = {
                frecency = {
                    db_safe_mode = false,
                    matcher = "fuzzy",
                    path_display = { "shorten" }
                },
                git_file_history = {
                    -- Keymaps inside the picker
                    mappings = {
                        i = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                        n = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                    },

                    -- The command to use for opening the browser (nil or string)
                    -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
                    browser_command = nil,
                },
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown({
                        -- 設定オプション
                        layout_config = {
                            height = 15,
                            width = 90,
                        },
                    })
                },
                windows = {},
            },
        })

        telescope.load_extension("live_grep_args")
        telescope.load_extension("git_file_history")
        telescope.load_extension('ui-select')

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fb", function()
            builtin.buffers({
                sort_mru = true,
                ignore_current_buffer = true
            })
        end, { desc = "Switch among buffers", })
        vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "Change colorscheme", })
        vim.keymap.set("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files({ hidden = true })<CR>", { desc = "Find files", })
        vim.keymap.set("n", "<leader>fF", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer", })
        vim.keymap.set("n", "<leader>fr", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
            { desc = "Live grep", })
        vim.keymap.set("n", "<leader>fg", builtin.grep_string, { desc = "Grep string", })
        vim.keymap.set("n", "<leader>fo", function() builtin.oldfiles({ cwd_only = true }) end,
            { desc = "Old files in the current directory", })
        vim.keymap.set("n", "<leader>fp", builtin.registers, { desc = "Registers", })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics", })
        vim.keymap.set("n", "<leader>fm", builtin.lsp_document_symbols,
            { desc = "Symbols in the file such as functions and structs", })
        vim.keymap.set("n", "<leader>fn", telescope.extensions.notify.notify, { desc = "Notify", })
        vim.keymap.set("n", "<leader>fh", telescope.extensions.git_file_history.git_file_history,
            { desc = "Git file history", })
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP definitions", })
        vim.keymap.set("n", "gD", builtin.lsp_type_definitions, { desc = "LSP type definitions", })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP references", })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP implementations", })
    end,
}
