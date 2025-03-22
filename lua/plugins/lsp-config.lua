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

      local function copy_hover_to_clipboard()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, _, _)
          if err or not result or not result.contents then
            return
          end

          local content
          if type(result.contents) == 'string' then
            content = result.contents
          elseif result.contents.value then
            content = result.contents.value
          else
            content = result.contents[1].value
          end

          -- Remove Markdown formatting if present
          content = content:gsub('```%w*\n', ''):gsub('```', '')

          -- Copy to clipboard
          vim.fn.setreg('+', content)
          print('Hover documentation copied to clipboard!')
        end)
      end

      vim.keymap.set('n', '<leader>ch', copy_hover_to_clipboard, { desc = 'Copy hover documentation to clipboard' })
    end,
  },
}
