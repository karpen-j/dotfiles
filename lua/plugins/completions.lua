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
      require('luasnip.loaders.from_vscode').lazy_load({
        exclude = { 'bef' },
      })
      require('luasnip').filetype_extend('ruby', { 'rails' })
      require('luasnip').filetype_extend('javascript', { 'html' })
      require('luasnip').filetype_extend('javascriptreact', { 'html' })
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/lua/plugins/my-snippets' } })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

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
          { name = 'buffer' },
          {
            name = 'spell',
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return require('cmp.config.context').in_treesitter_capture('spell')
              end,
              preselect_correct_word = true,
            },
          },
        }),
      })

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      vim.keymap.set('i', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', { desc = 'Cmp exapnd or jump' })
      vim.keymap.set('i', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>', { desc = 'Cmp jump -1' })
      vim.keymap.set('s', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', { desc = 'Cmp exapnd or jump' })
      vim.keymap.set('s', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>', { desc = 'Cmp jump -1' })
    end,
  },
}
