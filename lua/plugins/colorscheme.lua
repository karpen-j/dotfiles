return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('bamboo').setup({
      style = 'multiplex',
      highlights = {
        -- make comments blend nicely with background, similar to other color schemes
        ['@comment'] = { fg = '$grey' },
      },
    })
    require('bamboo').load()
  end,
}
