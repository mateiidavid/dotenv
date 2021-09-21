
-- In Lua, there are three types of config:
--  vim.api.nvim_set_option() — global options
-- vim.api.nvim_buf_set_option() — buffer-local options
-- vim.api.nvim_win_set_option() — window-local options
-- config files get required here
local cmd = vim.cmd -- alias to execute Vim commands, e.g cmd('pwd')
local fn = vim.fn -- alias to call Vim functions, e.g :fn.bufnr()
local g = vim.g -- alias to a table to access global variables

vim.g.mapleader = ","

require('options')

-- set-up packer
require('packer').startup(function ()
  use 'wbthomason/packer.nvim' -- packer can manage itself, better it autoupdates I guess
  
  -- --- LSP Config -- 
  use 'neovim/nvim-lspconfig' -- lspconfig
  use 'glepnir/lspsaga.nvim'

  -- --- Util ---
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


  -- --- Themes ---
  use 'ayu-theme/ayu-vim'
  use 'shaunsingh/moonlight.nvim'
  use 'folke/tokyonight.nvim' 
end)

cmd[[colorscheme tokyonight]] -- set color theme

-- Maps
-- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {noremap = true})
-- switch & delete buffers
vim.api.nvim_set_keymap('n', '<leader><leader>', '<c-^>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>c', ':bd <CR>', {noremap = true})
