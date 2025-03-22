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

function CreateFileWithDirs(filepath)
  vim.fn.system('install -D /dev/null ' .. filepath)
  vim.cmd('write! ' .. filepath)
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
vim.opt.updatetime     = 200
vim.opt.wrap           = true

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<leader>T', ':lua RunRSpecOnCurrentLine(0)<CR>', { desc = 'Run rspec on whole file' })
vim.keymap.set('n', '<leader>bp', 'obinding.pry<Esc>', { desc = 'Paste binding.pry' })
vim.keymap.set('n', '<leader>cc', ':let @+=expand("%:.")<CR>', { desc = 'Copy filepath to clipboard' })
vim.keymap.set('n', '<leader>cs', ':lua CamelToSnakeWord()<CR>', { desc = 'Change current word to snake case' })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Turn off highlighing' })
vim.keymap.set('n', '<leader>sc', ':lua SnakeToCamelWord()<CR>', { desc = 'Change current word to camel case' })
vim.keymap.set(
  'n',
  '<leader>t',
  ':lua RunRSpecOnCurrentLine(vim.fn.line("."))<CR>',
  { desc = 'Run rspec on current line' }
)
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('v', '<leader>ft', "! tr -s \" \" | column -t -s '|' -o '|'<CR>", { desc = 'Format markdown table' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without pasting it to clipboard' })

vim.api.nvim_create_user_command('Touch', function(opts)
  CreateFileWithDirs(opts.args)
end, { nargs = 1 })
