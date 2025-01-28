return {
  'icholy/lsplinks.nvim',
  config = function()
    local lsplinks = require('lsplinks')
    lsplinks.setup()
    vim.keymap.set('n', '<leader>gx', lsplinks.gx, { desc = 'Go to lsp documentLink' })
  end,
}
