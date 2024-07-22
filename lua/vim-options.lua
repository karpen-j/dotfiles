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
  vim.cmd('w')
  local file_name = vim.fn.expand('%')
  local rspec_command = string.format('rspec %s:%d && exit\n', file_name, line_number)
  vim.cmd('belowright split term://zsh')
  vim.cmd('startinsert')
  vim.api.nvim_chan_send(vim.b.terminal_job_id, rspec_command)
end

vim.g.mapleader = ' '
vim.g.background = 'light'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = '120'
vim.opt.textwidth = 120
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamed'
vim.opt.updatetime = 50

vim.wo.number = true

-- Navigate vim panes better
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', '<leader>sc', ':lua SnakeToCamelWord()<CR>')
vim.keymap.set('n', '<leader>cs', ':lua CamelToSnakeWord()<CR>')
vim.keymap.set('n', '<leader>bp', 'obinding.pry<Esc>')
vim.keymap.set('n', '<leader>t', ':lua RunRSpecOnCurrentLine(vim.fn.line("."))<CR>')
vim.keymap.set('n', '<leader>T', ':lua RunRSpecOnCurrentLine(0)<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
