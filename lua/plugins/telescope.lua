return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      local lga_actions = require('telescope-live-grep-args.actions')
      local actions = require('telescope.actions')

      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
          live_grep_args = {
            mappings = {
              i = {
                ['<C-k>'] = lga_actions.quote_prompt(),
                ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,
              },
            },
          },
        },
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.99,
            height = 0.7,
            horizontal = {
              preview_width = 0.5,
            },
          },
        },
      })
      local builtin = require('telescope.builtin')
      local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')

      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      vim.keymap.set('n', '<leader>gc', live_grep_args_shortcuts.grep_word_under_cursor)
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, {})

      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('live_grep_args')
    end,
  },
}
