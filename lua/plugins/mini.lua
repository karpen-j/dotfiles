return {
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      require('mini.ai').setup()
    end,
  },
  {
    'echasnovski/mini.align',
    version = '*',
    config = function()
      require('mini.align').setup()
    end,
  },
  {
    'echasnovski/mini.basics',
    version = '*',
    config = function()
      require('mini.basics').setup({
        mappings = {
          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = true,

          -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
          move_with_alt = true,
        },
      })
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      require('mini.indentscope').setup()
    end,
  },
  {
    'echasnovski/mini.jump',
    version = '*',
    config = function()
      require('mini.jump').setup()
    end,
  },
  {
    'echasnovski/mini.jump2d',
    version = '*',
    config = function()
      require('mini.jump2d').setup()
    end,
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup()
    end,
  },
  {
    'echasnovski/mini.operators',
    version = '*',
    config = function()
      require('mini.operators').setup()
    end,
  },
  {
    'echasnovski/mini.splitjoin',
    version = '*',
    config = function()
      require('mini.splitjoin').setup()
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup({
        search_method = 'cover_or_next',
        custom_surroundings = {
          ['d'] = { output = { left = 'do\n', right = '\nend' } },
          ['n'] = { output = { left = '\n', right = '\n' } },
        },
      })
    end,
  },
}
