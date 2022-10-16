local cmd = vim.cmd -- alias to execute Vim commands, e.g cmd('pwd')

require('settings')
require('fn')
require('plugins')
require('mappings').core_bindings()
--vim.g.tokyonight_style = "night"
--cmd[[colorscheme tokyonight]] -- set color theme
--require('nightfox').load('nightfox')
cmd([[colorscheme catppuccin]])

cmd([[command! Bufs :buffers]])

require('lang-conf')
