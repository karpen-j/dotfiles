return {
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip').filetype_extend('ruby', { 'rails' })
      require('luasnip').filetype_extend('javascript', { 'html' })
      require('luasnip').filetype_extend('javascriptreact', { 'html' })
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/lua/plugins/my-snippets' } })

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        }),
      })

      vim.keymap.set('i', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>')
      vim.keymap.set('i', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>')
      vim.keymap.set('s', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>')
      vim.keymap.set('s', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>')
    end,
  },
}
