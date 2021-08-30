
i-- In Lua, there are three types of config:
--  vim.api.nvim_set_option() — global options
-- vim.api.nvim_buf_set_option() — buffer-local options
-- vim.api.nvim_win_set_option() — window-local options
-- config files get required here
require('settings')
require('lsp')
require('statusline')

