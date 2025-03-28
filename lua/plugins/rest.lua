return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
  },
  config = function()
    require('rest-nvim').setup({
      cookie = {
        enable = false,
      },
    })
    require('telescope').load_extension('rest')

    vim.keymap.set('n', '<leader>rr', ':Rest run<CR>', { desc = 'Run request under cursor' })
    vim.keymap.set('n', '<leader>re', ':Telescope rest select_env<CR>', { desc = 'Select env file' })
  end,
}
