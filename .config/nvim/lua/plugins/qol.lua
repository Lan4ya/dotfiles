return {
    -- goated
    { 'shortcuts/no-neck-pain.nvim', version = '*', cmd = 'NoNeckPain' },

    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = '1.*',
        build = vim.g.lazyvim_blink_main and 'cargo build --release',
        config = function()
            require 'configs.blink'
        end,
    },
    -- {
    --     'hrsh7th/nvim-cmp',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-nvim-lua',
    --         'hrsh7th/cmp-cmdline',
    --         'onsails/lspkind.nvim',
    --         'L3MON4D3/LuaSnip',
    --         'saadparwaiz1/cmp_luasnip',
    --         'rafamadriz/friendly-snippets',
    --         'brenoprata10/nvim-highlight-colors',
    --         {
    --             'folke/lazydev.nvim',
    --             ft = 'lua',
    --             opts = {
    --                 library = {
    --                     { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    --                 },
    --             },
    --         },
    --     },
    --     opts = require('configs.cmp').opts,
    --     config = require('configs.cmp').config,
    -- },

    {
        'neovim/nvim-lspconfig',
        event = 'User FilePost',
        -- event = 'VeryLazy',
        dependencies = {
            'williamboman/mason.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'j-hui/fidget.nvim',
        },
        config = function()
            require 'configs.lsp._lsp'
        end,
    },

    -- makes file ops lsp-aware. It notifies
    -- the lsp so imports and references update automatically.
    {
        'antosha417/nvim-lsp-file-operations',
        event = 'VeryLazy',
        config = function()
            require('lsp-file-operations').setup()
        end,
    },

    -- {
    --     'folke/snacks.nvim',
    --     event = 'VeryLazy',
    --     opts = {
    --         rename = {
    --             enabled = true,
    --         },
    --     },
    -- },

    -- smarter folding
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'VeryLazy',
        -- event = 'BufReadPost',
        opts = function()
            return require 'configs.nvim_ufo'
        end,
    },

    -- multi cursor
    {
        'mg979/vim-visual-multi',
        branch = 'master',
        event = 'VeryLazy',
        -- init instead of config for remaps to work
        -- See https://github.com/mg979/vim-visual-multi/issues/241
        init = function()
            require 'configs.visual_multi'
        end,
    },

    -- view images in neovim (terminal emulator has to have support for image rendering)
    {
        '3rd/image.nvim',
        event = 'VeryLazy',
        -- commit = '4206c48',
        config = function()
            require 'configs.image_nvim.image'
            -- require 'configs.image_nvim.luarocks' -- deps
        end,
    },

    -- enhances nvim's native comment strings
    {
        'folke/ts-comments.nvim',
        opts = {},
        event = 'VeryLazy',
    },

    -- indentation guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            indent = {
                highlight = {
                    'RainbowRed',
                    'RainbowYellow',
                    'RainbowBlue',
                    'RainbowOrange',
                    'RainbowGreen',
                    'RainbowViolet',
                    'RainbowCyan',
                },
                char = '│',
                tab_char = '│',
            },
            scope = {
                enabled = false, -- don't use ibl scope since mini.indentscope handles it
            },
            exclude = {
                filetypes = {
                    'help',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'Trouble',
                    'lazy',
                    'mason',
                    'notify',
                    'toggleterm',
                    'snacks_dashboard',
                    'snacks_notif',
                    'snacks_terminal',
                    'snacks_win',
                },
            },
        },
        config = function(_, opts)
            local hooks = require 'ibl.hooks'
            local set_hl = vim.api.nvim_set_hl

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                set_hl(0, 'RainbowRed', { fg = '#3a2e33' })
                set_hl(0, 'RainbowYellow', { fg = '#3a3629' })
                set_hl(0, 'RainbowGreen', { fg = '#2e3a2e' })
                set_hl(0, 'RainbowCyan', { fg = '#2c3a3a' })
                set_hl(0, 'RainbowBlue', { fg = '#2c323d' })
                set_hl(0, 'RainbowViolet', { fg = '#342e3d' })
                set_hl(0, 'RainbowOrange', { fg = '#3a3029' })
            end)

            require('ibl').setup(opts)
        end,
    },

    -- active scope indentation guide
    {
        'echasnovski/mini.indentscope',
        version = false,
        event = { 'BufReadPost', 'BufNewFile' },
        opts = function()
            -- local indentscope = require 'mini.indentscope'
            return {
                symbol = '│',
                options = { try_as_border = true },
                -- draw = {
                --     delay = 0,
                --     animation = indentscope.gen_animation.none(),
                -- },
            }
        end,
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'help',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'Trouble',
                    'lazy',
                    'mason',
                    'notify',
                    'toggleterm',
                    'snacks_dashboard',
                    'snacks_notif',
                    'snacks_terminal',
                    'snacks_win',
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
