
-- In Lua, there are three types of config:
--  vim.api.nvim_set_option() — global options
-- vim.api.nvim_buf_set_option() — buffer-local options
-- vim.api.nvim_win_set_option() — window-local options
-- config files get required here
local cmd = vim.cmd -- alias to execute Vim commands, e.g cmd('pwd')
local fn = vim.fn -- alias to call Vim functions, e.g :fn.bufnr()
local g = vim.g -- alias to a table to access global variables
local opt = vim.opt -- alias to set options more easily.

-- set-up packer
require('packer').startup(function ()
  use 'wbthomason/packer.vim' -- packer can manage itself, better it autoupdates I guess

  use 'neovim/nvim-lspconfig'

end)

