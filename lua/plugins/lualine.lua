return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'cuducos/yaml.nvim',
  },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'bamboo',
      },
      sections = {
        lualine_a = {
          {
            'mode',
            icons_enabled = true,
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = {
          require('yaml_nvim').get_yaml_key,
          'rest',
        },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
    })
  end,
}
