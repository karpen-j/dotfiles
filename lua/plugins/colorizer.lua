return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      'css',
      'scss',
      'javascript',
      'html',
    }, {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
    })
    vim.cmd('ColorizerAttachToBuffer')
  end,
}
