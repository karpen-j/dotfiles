return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
    vim.keymap.set('n', '<leader>bf', ':Neotree buffers reveal float<CR>')
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
          indent_size = 1,
        },
      },
    })
  end,
}
