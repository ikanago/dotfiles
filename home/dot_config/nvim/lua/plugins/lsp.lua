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
          vim.cmd[[set completeopt+=menuone,noselect,popup]]
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, {autotrigger = true})
            vim.keymap.set('i', '<c-space>', function()
              vim.lsp.completion.get()
            end)
          end

          vim.diagnostic.config({
            signs = false,
            virtual_text = {
              format = function(diagnostic)
                return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
              end,
            },
          })

          function map(key, action, desc)
            local opts = { noremap = true, silent = true, buffer = event.buf, desc = "LSP: " .. desc }
            vim.keymap.set('n', key, action, opts)
          end

          map('ga', vim.lsp.buf.code_action, 'Code Action')
          map('gd', vim.lsp.buf.definition, 'Go to Definition')
          map('<leader>D', vim.lsp.buf.type_definition, 'Go to Type Definition')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
        end,
      })
    end
  }
}
