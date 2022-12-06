require('settings')
require('fn')
require('plugins')
require('mappings').core_bindings()
--vim.g.tokyonight_style = "night"
--cmd[[colorscheme tokyonight]] -- set color theme
--require('nightfox').load('nightfox')
--cmd([[colorscheme catppuccin]])

vim.cmd([[command! Bufs :buffers]])
vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = { '*.lua' }, command = 'Format' })
vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  { pattern = { '*.rs', '*.go', '*.c' }, callback = vim.lsp.buf.formatting_sync }
)
--cmd([[autocmd BufWritePre *.lua Format]])
--cmd([[autocmd BufWritePre *.go vim.lsp.buf.formatting_sync()]])
--cmd([[autocmd BufWritePre *.rust vim.lsp.buf.formatting_sync()]]) lol, do I
--even write Rust? Filetype "RUST"
-- autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
require('lspcfg').setup()
