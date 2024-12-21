function SnakeToCamelWord()
  local word = vim.fn.expand('<cword>')
  local new_word = word:gsub('_(.)', function(c)
    return c:upper()
  end)
  vim.cmd('normal! ciw' .. new_word)
end

function CamelToSnakeWord()
  local word = vim.fn.expand('<cword>')
  local new_word = word:gsub('([A-Z])', function(c)
    return '_' .. c:lower()
  end)
  vim.cmd('normal! ciw' .. new_word)
end

function RunRSpecOnCurrentLine(line_number)
  local file_name = vim.fn.expand('%')
  local rspec_command = string.format('rspec %s:%d && exit\n', file_name, line_number)

  vim.cmd('w')
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd('startinsert')
  vim.api.nvim_chan_send(vim.b.terminal_job_id, rspec_command)
end

vim.g.mapleader = ' '

vim.opt.autoindent     = true
vim.opt.clipboard      = 'unnamed'
vim.opt.colorcolumn    = '120'
vim.opt.expandtab      = true
vim.opt.relativenumber = true
vim.opt.scrolloff      = 8
vim.opt.shiftwidth     = 2
vim.opt.softtabstop    = 2
vim.opt.spell          = true
vim.opt.spelllang      = { 'en_us', 'ru' }
vim.opt.swapfile       = false
vim.opt.tabstop        = 2
vim.opt.textwidth      = 116
vim.opt.updatetime     = 50
vim.opt.wrap           = true

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<leader>T', ':lua RunRSpecOnCurrentLine(0)<CR>')
vim.keymap.set('n', '<leader>bp', 'obinding.pry<Esc>')
vim.keymap.set('n', '<leader>cc', ':let @+=expand("%:.")<CR>')
vim.keymap.set('n', '<leader>cs', ':lua CamelToSnakeWord()<CR>')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>sc', ':lua SnakeToCamelWord()<CR>')
vim.keymap.set('n', '<leader>t', ':lua RunRSpecOnCurrentLine(vim.fn.line("."))<CR>')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
