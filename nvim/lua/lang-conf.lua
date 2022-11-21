local lspconfig = require('lspconfig')

-- //
-- // Diagnostics
-- //
-- Disable virtual_text, using lsp_lines
vim.diagnostic.config({
  virtual_text = false,
  --virtual_lines = { only_current_line = true },
  virtual_lines = false,
})

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    signs = {
      enable = true,
      priority = 20,
    },
    -- Disable a feature
    update_in_insert = false,
  })

local on_attach = function(_client, bufnr)
  require('mappings').lsp_bindings(bufnr)
  local buf_set_option = function(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('textwidth', 80)

  -- Remove 't'? added 'q', 'j'
  buf_set_option('formatoptions', 'c' .. 'r' .. 'q' .. 'b' .. 'j')
end

-- //
-- // CMP
-- //
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_next_item(),
    ['<C-n>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  }),
  completion = {
    autocomplete = false,
  },
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- //
-- // LSP Config
-- //
-- Go
lspconfig.gopls.setup({
  cmd = { 'gopls', 'serve' },
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
})

-- Rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  commands = {
    Format = {
      function()
        require('stylua-nvim').format_file()
      end,
    },
  },
})

-- Lua
lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  commands = {
    Format = {
      function()
        require('stylua-nvim').format_file()
      end,
    },
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
--require('rust-tools').setup({})

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = lsp_capabilities,
})
