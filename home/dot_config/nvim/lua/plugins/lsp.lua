-- based `:h lsp-attach`
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- auto formatting
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 3000 })
                end,
            })
        end

        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.cmd [[set completeopt+=menuone,noselect,popup]]
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
        })
    end,
})

return {
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
        config = true,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "neovim/nvim-lspconfig" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = true,
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "rust_analyzer",
                "solargraph",
            }
        },
        keys = {
            { "<C-space>", "<cmd>lua vim.lsp.completion.get()<CR>", mode = "i" },
            { "ga",        "<cmd>lua vim.lsp.buf.code_action()<CR>" },
            { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>" },
            { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>" },
            { "gh",        "<cmd>lua vim.lsp.buf.hover()<CR>" },
        },
    },
}
