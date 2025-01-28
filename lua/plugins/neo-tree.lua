return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    local config = require('neo-tree')
    config.setup({
      close_if_last_window = true,
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        width = 28,
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_by_pattern = {},
        },
        follow_current_file = {
          enabled = true,
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
        },
      },
    })

    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>', { desc = 'Neotree filesystem reveal' })
    vim.keymap.set('n', '<leader>bf', ':Neotree buffers reveal float<CR>', { desc = 'Neotree buffers reveal' })
  end,
}
