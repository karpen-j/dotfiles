return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('render-markdown').setup({
      enabled = false,
    })

    vim.keymap.set('n', '<leader>rm', ':RenderMarkdown toggle<CR>', { desc = 'Render markdown toggle' })
  end,
}
