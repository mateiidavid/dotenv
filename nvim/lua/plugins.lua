vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'Packer',
    pattern = '*/lua/*.lua',
    callback = function()
        vim.cmd('source <afile>')
        vim.cmd('PackerCompile')
    end,
})

-- //
-- // Plugin set-up
-- //
local function telescope_setup()
    require('mappings').telescope_bindings()
    require('telescope').setup({
        pickers = {
            buffers = {
                theme = 'ivy',
            },
            live_grep = {
                theme = 'dropdown',
            },
            help_tags = {
                theme = 'dropdown',
            },
            find_files = {
                theme = 'ivy',
            },
            man_pages = {
                theme = 'dropdown',
            },
        },
    })
end

local function treesitter_setup()
    require('nvim-treesitter.parsers').get_parser_configs().just = {
        install_info = {
            url = 'https://github.com/IndianBoy42/tree-sitter-just', -- local path or git repo
            files = { 'src/parser.c', 'src/scanner.cc' },
            branch = 'main',
        },
        maintainers = { '@IndianBoy42' },
    }

    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'rust', 'yaml', 'toml', 'go', 'bash', 'lua', 'fish', 'html', 'json', 'just' }, -- one
        -- of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            --disable = { "c", "rust" },  -- list of language that will be disabled
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        },
        autopairs = { enable = true },
    })
end

local function lualine_setup()
    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'palenight',
            --component_separators = { left = '', right = ''},
            component_separators = { left = ' ', right = ' ' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1, -- 1 is relative, 2 is abs
                    shorting_target = 50,
                },
            },
            lualine_x = { 'diagnostics' },
            lualine_y = { 'encoding', 'fileformat', 'filetype' },
            lualine_z = { 'progress', 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    })
end

local function bufferline_setup()
    require('bufferline').setup({
        options = {
            mode = 'buffers',
            numbers = 'ordinal',
            color_icons = true,
            show_buffer_default_icon = true,
        },
    })
end
-- //
-- // Packer
-- //
return require('packer').startup(function(use)
    use('wbthomason/packer.nvim') -- packer can manage itself, better it autoupdates I guess

    use('/home/matei/workspace/side-projects/blame.nvim')
    -- --- LSP Config --
    use('neovim/nvim-lspconfig') -- lspconfig
    use('simrat39/rust-tools.nvim')
    use({
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('gitsigns').setup()
        end,
    })

    use('L3MON4D3/LuaSnip')
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'saadparwaiz1/cmp_luasnip',
        },
    })
    use('ckipp01/stylua-nvim')
    -- --- Util ---
    use({
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = telescope_setup,
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = treesitter_setup,
    })
    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                disable_filetype = { 'TelescopePrompt' },
            })
        end,
    })

    -- --- Themes/UI ---
    use('EdenEast/nightfox.nvim')
    use('ayu-theme/ayu-vim')
    use('tpope/vim-fugitive')
    use('shaunsingh/moonlight.nvim')
    use('folke/tokyonight.nvim')

    use({
        'catppuccin/nvim',
        as = 'catppuccin',
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = lualine_setup,
    })

    use({
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
        end,
    })

    use({
        'akinsho/bufferline.nvim',
        tag = 'v2.*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = bufferline_setup,
    })
end)
