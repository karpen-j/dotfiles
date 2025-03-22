return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local fortune = require('alpha.fortune')
    -- Set header
    dashboard.section.header.val = {
      '███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ',
      '███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ',
      '███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ',
      '███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ',
      '███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ',
      '███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ',
      '███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ',
      ' ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ',
    }
    dashboard.section.buttons.val = {
      dashboard.button('e', ' > New File', ':ene<CR>'),
      dashboard.button('f', '󰱼 > Find Files', ':Telescope find_files<CR>'),
      dashboard.button('r', ' > Find Recent Files', ':Telescope oldfiles<CR>'),
      dashboard.button('p', ' > Find Projects', ':Telescope project<CR>'),
      dashboard.button('c', ' > Configuration', ':edit ~/.config/nvim/init.lua<CR>'),
      dashboard.button('q', ' > Quit NVIM', ':qa<CR>'),
    }
    dashboard.section.footer.val = fortune()
    alpha.setup(dashboard.opts)
  end,
}
