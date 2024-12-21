return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'solargraph', 'lua_ls', 'ts_ls', 'yamlls' },
        opts = {
          auto_install = true,
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')
      lspconfig.solargraph.setup({
        cmd = { 'solargraph', 'stdio' },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          solargraph = {
            useBundler = true,
            workspace = true,
            completion = true,
            diagnostics = false,
            formatting = false,
          },
        },
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', { desc = 'Find references' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
    end,
  },
}
