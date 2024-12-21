return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rubocop.with({
          command = 'bundle',
          args = { 'exec', 'rubocop', '-a', '--stdin', '$FILENAME', '--stderr' },
          env = { RUBYOPT = '-W0' },
        }),
        null_ls.builtins.diagnostics.erb_lint,
        null_ls.builtins.diagnostics.rubocop.with({
          command = 'bundle',
          args = { 'exec', 'rubocop', '--editor-mode', '--format', 'json', '--stdin', '$FILENAME' },
          env = { RUBYOPT = '-W0' },
        }),
      },
    })

    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format({ timeout_ms = 10000 })
    end)
    vim.keymap.set('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>zz')
    vim.keymap.set('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>zz')
  end,
}
