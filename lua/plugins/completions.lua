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
    'lukas-reineke/cmp-rg',
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
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
          ['<Tab>'] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<A-y>'] = require('minuet').make_cmp_map(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'minuet' },
          { name = 'luasnip' }, -- For luasnip users.
          {
            name = 'rg',
            -- Try it when you feel cmp performance is poor
            keyword_length = 3,
          },
        },
        performance = {
          -- It is recommended to increase the timeout duration due to
          -- the typically slower response speed of LLMs compared to
          -- other completion sources. This is not needed when you only
          -- need manual completion.
          fetching_timeout = 2000,
        },
      })

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      vim.keymap.set('i', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', { desc = 'Cmp exapnd or jump' })
      vim.keymap.set('i', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>', { desc = 'Cmp jump -1' })
      vim.keymap.set('s', '<C-k>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', { desc = 'Cmp exapnd or jump' })
      vim.keymap.set('s', '<C-j>', '<cmd>lua require("luasnip").jump(-1)<CR>', { desc = 'Cmp jump -1' })
    end,
  },
}
