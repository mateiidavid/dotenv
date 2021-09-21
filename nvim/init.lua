
-- In Lua, there are three types of config:
--  vim.api.nvim_set_option() — global options
-- vim.api.nvim_buf_set_option() — buffer-local options
-- vim.api.nvim_win_set_option() — window-local options
-- config files get required here
local cmd = vim.cmd -- alias to execute Vim commands, e.g cmd('pwd')
local fn = vim.fn -- alias to call Vim functions, e.g :fn.bufnr()
local g = vim.g -- alias to a table to access global variables
local opt = vim.opt -- alias to set options more easily.

-- Options
opt.tabstop =  4 opt.softtabstop =  2
opt.shiftwidth = 2
opt.expandtab  =  true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
-- vim.api.nvim_set_option('nohlsearch', true)
opt.hidden = true
-- nvim history, not important to know just take it as it is I guess
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = '~/.nvim/undodir'
opt.undofile = true
opt.mouse = 'a'
opt.incsearch = true
opt.scrolloff = 8
opt.termguicolors = true
vim.wo.colorcolumn = '120'
opt.formatoptions = 'tc'  -- wrap text and comments using textwidth
opt.formatoptions = opt.formatoptions + 'r'  -- continue comments when pressing ENTER in I mode
opt.formatoptions = opt.formatoptions + 'b'  -- auto-wrap in insert mode, and do not wrap old long lines
opt.termguicolors = true -- won't get rid of this it seems, required by ayu
opt.textwidth = 80
vim.g.mapleader = ","
cmd [[syntax enable]] -- enable syntax
cmd [[highlight ColorColumn ctermbg=0 guibg=lightgrey]]
cmd [[filetype plugin indent on]] -- file id, plugin and identing

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
