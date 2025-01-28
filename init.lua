local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.neovide then
  vim.o.guifont = 'FiraMono Nerd Font Propo:h10'
  vim.g.neovide_fullscreen = true

  vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<C-S-v>', function()
    vim.api.nvim_paste(vim.fn.getreg('+'), true, -1)
  end, { noremap = true, silent = true })
end

require('env')
require('vim-options')
require('lazy').setup('plugins')
