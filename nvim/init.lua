
-- In Lua, there are three types of config:
--  vim.api.nvim_set_option() — global options
-- vim.api.nvim_buf_set_option() — buffer-local options
-- vim.api.nvim_win_set_option() — window-local options
-- config files get required here
local cmd = vim.cmd -- alias to execute Vim commands, e.g cmd('pwd')
local fn = vim.fn -- alias to call Vim functions, e.g :fn.bufnr()
local g = vim.g -- alias to a table to access global variables

vim.g.mapleader = " "

require('settings')
require'fn'

-- set-up packer
require('packer').startup(function ()
  use 'wbthomason/packer.nvim' -- packer can manage itself, better it autoupdates I guess
  
  -- --- LSP Config -- 
  use 'neovim/nvim-lspconfig' -- lspconfig
  use 'glepnir/lspsaga.nvim' -- think this is deprecated? not worked on at any rate
  use 'simrat39/rust-tools.nvim'
  use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('gitsigns').setup()
  end
}

  use 'L3MON4D3/LuaSnip'
  use {
    "hrsh7th/nvim-cmp", 
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',

    }
  }
  -- --- Util ---
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup({
        disable_filetype= {"TelescopePrompt"}
      })
    end
  }
  
  -- --- Themes/UI ---
  use 'EdenEast/nightfox.nvim'
  use 'ayu-theme/ayu-vim'
  use 'tpope/vim-fugitive'
  use 'shaunsingh/moonlight.nvim'
  use 'folke/tokyonight.nvim' 
  use {
    'beauwilliams/statusline.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
      {'nvim-lua/lsp-status.nvim'},
      {'kosayoda/nvim-lightbulb'},
    }      
  }

  use({
	"catppuccin/nvim",
	as = "catppuccin"
  })

  use {
  'nvim-lualine/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  
end)

 --vim.g.tokyonight_style = "night"
 --cmd[[colorscheme tokyonight]] -- set color theme
--require('nightfox').load('nightfox')
cmd[[colorscheme catppuccin]]

local key_maps = {
  {mode = 'n', lhs = '<C-h>', rhs = ':wincmd h<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<C-j>', rhs = ':wincmd j<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<C-k>', rhs = ':wincmd k<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<C-l>', rhs = ':wincmd l<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<leader>c', rhs = ':bd <CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<C-p>', rhs = ':Telescope find_files<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<leader>fb', rhs = ':Telescope buffers<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<leader>fh', rhs = ':Telescope help_tags<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<leader>fg', rhs = ':Telescope live_grep<CR>', opts = {noremap = true}},
  {mode = 'n', lhs = '<leader>mp', rhs = ':Telescope man_pages<CR>', opts = {noremap = true}},
}

-- TODO: move this into util file
-- re-use it for lang srv
local set_key = function(maps) 
  for _, v in pairs(maps) do
    vim.api.nvim_set_keymap(v.mode, v.lhs, v.rhs, v.opts)
  end
end

set_key(key_maps)
cmd[[command! Bufs :buffers]]

require'telescope'.setup({
  pickers = {
    buffers = {
      theme = "ivy",
    },
    live_grep = {
      theme = "cursor",
    },
    help_tags = {
      theme = "dropdown",
    },
    find_files = {
      theme = "ivy",
    },
    man_pages = {
      theme = "dropdown",
    },
  },
})

-- Maps
-- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
--vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {noremap = true})
---- switch & delete buffers
--vim.api.nvim_set_keymap('n', '<leader><leader>', '<c-^>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>c', ':bd <CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-p>', ":Telescope find_files<CR>", {noremap=true})
--vim.api.nvim_set_keymap('n', '<leader>b', ":Telescope buffers<CR>", {noremap=true})
--vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true})


--local statusline = require('statusline')
require'lang-conf'
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'palenight',
    --component_separators = { left = '', right = ''},
    component_separators = { left = ' ', right = ' '},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {{
      'filename',
      file_status = true,
      path = 1, -- 1 is relative, 2 is abs
      shorting_target = 50,
    }},
    lualine_x = {'diagnostics'},
    lualine_y = {'encoding', 'fileformat', 'filetype'},
    lualine_z = {'progress', 'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

