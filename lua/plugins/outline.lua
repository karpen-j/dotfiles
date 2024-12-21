return {
  'hedyhli/outline.nvim',
  config = function()
    vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

    require('outline').setup({
      outline_window = {
        auto_close = true,
        auto_jump = true,
        show_numbers = true,
        show_relative_numbers = true,
      },
      providers = {
        priority = { 'lsp', 'markdown', 'norg' },
        lsp = {
          blacklist_clients = {},
        },
        markdown = {
          filetypes = { 'markdown' },
        },
      },
    })
  end,
}
