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

local servers = {
    "clangd",
    "gopls",
    "lua_ls",
    "rust_analyzer",
    "solargraph",
    "terraformls",
}

-- Equivalent of mason-lspconfig's `ensure_installed`.
-- Mason package names (lua-language-server) differ from lspconfig server names
-- (lua_ls), so build a lookup table from `spec.neovim.lspconfig` in mason-registry.
local function ensure_installed(names)
    local registry = require("mason-registry")
    registry.refresh(function()
        local package_names = {}
        for _, spec in ipairs(registry.get_all_package_specs()) do
            local lspconfig_name = vim.tbl_get(spec, "neovim", "lspconfig")
            if lspconfig_name then
                package_names[lspconfig_name] = spec.name
            end
        end

        for _, name in ipairs(names) do
            local package_name = package_names[name]
            if package_name then
                local pkg = registry.get_package(package_name)
                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end
    end)
end

return {
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },
    {
        -- Never required directly; it is here only to put its lsp/*.lua server
        -- definitions on the runtimepath for `vim.lsp.enable` to pick up.
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            ensure_installed(servers)
            vim.lsp.enable(servers)
        end,
        keys = {
            { "<C-space>", "<cmd>lua vim.lsp.completion.get()<CR>", mode = "i" },
            { "ga",        "<cmd>lua vim.lsp.buf.code_action()<CR>" },
            { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>" },
            { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>" },
            { "gh",        "<cmd>lua vim.lsp.buf.hover()<CR>" },
        },
    },
}
