return {
    { 'nvim-lua/plenary.nvim', event = 'VeryLazy' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Colorscheme
    -- {
    --     'gbprod/nord.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('nord').setup {
    --             transparent = false,
    --         }
    --         vim.cmd.colorscheme 'nord'
    --         local set_hl = vim.api.nvim_set_hl
    --         local muted_fg = '#C8D0E0'
    --
    --         set_hl(0, '@operator', { fg = '#1bfd9c' })
    --
    --         local highlights = {
    --             '@number',
    --             '@boolean',
    --             '@string',
    --             '@variable',
    --             -- '@keyword.function',
    --             -- '@function.call',
    --             -- '@function.builtin',
    --             '@tag',
    --         }
    --
    --         for _, hl in ipairs(highlights) do
    --             set_hl(0, hl, { fg = muted_fg })
    --         end
    --     end,
    -- },

    {
        'oxidescheme/nvim',
        name = 'oxide',
        lazy = false,
        priority = 1000,
        config = function()
            require('oxide').setup()
            vim.cmd.colorscheme 'oxide'
        end,
    },

    -- {
    --     -- 'andreypopp/vim-colors-plain',
    --     'pbrisbin/vim-colors-off',
    --     lazy = false,
    --     priority = 1000,
    --     init = function()
    --         vim.cmd [[colorscheme off]]
    --         -- vim.cmd [[colorscheme plain]]
    --         local set_hl = vim.api.nvim_set_hl
    --         set_hl(0, '@operator', { fg = '#1bfd9c' })
    --         vim.o.background = 'dark'
    --     end,
    -- },

    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()
            require 'configs.lualine'
        end,
    },

    -- Session manager
    {
        'rmagatti/auto-session',
        event = 'VimEnter',
        config = function()
            require 'configs.auto_session'
        end,
    },

    -- Automatic indentation styles
    {
        'tpope/vim-sleuth',
        event = { 'BufReadPre', 'BufNewFile' },
    },

    -- Auto pair paren, quotes, etc.
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter' },
        opts = {
            fast_wrap = {},
            disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        -- config = function(_, opts)
        --     require('nvim-autopairs').setup(opts)
        --     -- require('nvim-autopairs').enable_cmdline()
        -- end,
    },

    -- Git integrations (Yes, the 4 plugins below)
    {
        'tpope/vim-fugitive',
        cmd = { 'G', 'Git' },
    },

    -- Make fugitive cmd's async (not using other feats outside of that)
    { 'tpope/vim-dispatch', lazy = true },

    {
        'sindrets/diffview.nvim',
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewFileHistory',
            'DiffviewFocusFiles',
            'DiffviewLog',
            'DiffviewRefresh',
            'DiffviewToggleFiles',
        },
        config = function()
            require 'configs.diffview'
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        config = function()
            require 'configs.gitsigns'
        end,
    },

    -- File tree
    {
        'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        config = function()
            require 'configs.nvim_tree'
        end,
    },

    -- Blazingly fast???
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        event = 'VeryLazy',
        config = function()
            require 'configs.harpoon'
        end,
    },

    -- Better notifications
    {
        'rcarriga/nvim-notify',
        event = 'VeryLazy',
        config = function()
            require 'configs.notify'
        end,
    },

    -- File picker
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-telescope/telescope-frecency.nvim', version = '*' },
            { 'smartpde/telescope-recent-files' },
            { 'benfowler/telescope-luasnip.nvim' },
        },
        config = function()
            require 'configs.telescope'
        end,
    },

    -- Snippet engine
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' }, -- snippet collections from vscode
        verion = 'v2.*',
        build = 'make install_jsregexp',
        event = 'VeryLazy',
        config = function()
            require 'configs.luasnip'
        end,
    },

    -- Configures LuaLS for editing neovim
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    -- Keymap management
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require 'configs.which_key'
        end,
    },

    -- Colored todo comments
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        opts = function()
            require 'configs.todo'
        end,
    },

    -- UI for managing treesitter
    {
        'romus204/tree-sitter-manager.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'TSManager' },
        config = function()
            require 'configs.tree_sitter_manager'
        end,
    },

    -- Linter
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require 'configs.lint'
        end,
    },

    -- Auto-install linters referenced in nvim-lint
    {
        'rshkarin/mason-nvim-lint',
        config = function()
            require('mason-nvim-lint').setup {
                automatic_installation = true,
            }
        end,
    },

    -- Formatter
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        config = function()
            require 'configs.conform'
        end,
    },

    -- Surround, delete around, etc.
    {
        'kylechui/nvim-surround',
        version = '^3.0.0',
        event = 'VeryLazy',
        config = function()
            require 'configs.nvim_surround'
        end,
    },

    -- Better loclist && qflist
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
    },

    -- Provide bg color on color values
    {
        'brenoprata10/nvim-highlight-colors',
        event = 'VeryLazy',
        config = function()
            require 'configs.highlight_colors'
        end,
    },

    -- Tests
    -- {
    --     'nvim-neotest/neotest',
    --     event = 'VeryLazy',
    --     dependencies = {
    --         'nvim-neotest/nvim-nio',
    --         'antoinemadec/FixCursorHold.nvim',
    --         'marilari88/neotest-vitest',
    --         'nvim-neotest/neotest-jest',
    --     },
    --     config = function()
    --         require('neotest').setup {
    --             adapters = {
    --                 require 'neotest-vitest',
    --                 require 'neotest-jest',
    --             },
    --         }
    --     end,
    -- },

    -- Completion AI
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        dependencies = {
            'copilotlsp-nvim/copilot-lsp', -- for Next Edit Suggestion (NES)
        },
        config = function()
            require 'configs.copilot'
        end,
    },

    -- DB client UI
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer', 'DBUIRenameBuffer', 'DBUILastQueryInfo', 'DBUIHideNotifications' },
        config = function()
            require 'configs.dbui'
        end,
    },

    -- Markdown preview
    {
        'toppair/peek.nvim',
        event = { 'VeryLazy' },
        build = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup()
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },
}
