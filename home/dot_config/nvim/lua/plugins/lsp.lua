return {
  {
    'williamboman/mason.nvim',
    config = true,
    build = ':MasonUpdate',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'jsonls',
        'lua_ls',
        'rust_analyzer',
      },
    },
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    }
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
          if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, event.buf, {autotrigger = true})
          end
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf, desc = 'Go to definition' })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover' })
        end,
      })
    end
  }
}
