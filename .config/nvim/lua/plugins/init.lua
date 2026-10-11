return {
    { 'nvim-lua/plenary.nvim', event = 'VeryLazy' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Colorscheme
    {
        'gbprod/nord.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nord').setup {
                transparent = false,
            }
            vim.cmd.colorscheme 'nord'
            local set_hl = vim.api.nvim_set_hl
            local muted_fg = '#C8D0E0'

            set_hl(0, '@operator', { fg = '#1bfd9c' })

            local highlights = {
                '@number',
                '@boolean',
                '@string',
                '@variable',
                -- '@keyword.function',
                -- '@function.call',
                -- '@function.builtin',
                '@tag',
            }

            for _, hl in ipairs(highlights) do
                set_hl(0, hl, { fg = muted_fg })
            end
        end,
    },

    -- Colorscheme if I'm feeling psycho
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
            local custom_theme = require 'lualine.themes.nord'
            custom_theme.normal.c.bg = 'NONE'
            custom_theme.inactive.c.bg = 'NONE'

            require('lualine').setup {
                options = {
                    theme = custom_theme,
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            -- path = 1,
                        },
                    },
                },
            }
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

    -- Detects a projects indentation style and sets 'shiftwidth', 'tabstop', and 'expandtab' accordingly
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

    -- No more annoyinng default notif
    {
        'rcarriga/nvim-notify',
        event = 'VeryLazy',
        opts = {
            background_colour = '#000000',
            timeout = 3000, -- ms
            max_width = 65,
            stages = 'static',
            render = 'default',
            top_down = false,
        },
        config = function(_, opts)
            require('notify').setup(opts)

            -- override vim.notify
            vim.notify = require 'notify'
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
            require('luasnip').setup {
                history = false, -- Keep snippet history open to allow jumping backward
                -- keep_roots = true, -- Prevent $0 exit node from instantly destroying history
                keep_roots = false,
                region_check_events = 'InsertEnter,CursorMoved', -- Exit snippet tracking if cursor moves away
                delete_check_events = 'TextChanged,InsertLeave', -- Kill phantom sessions on text change or leaving Insert
            }
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_lua').load {
                paths = { vim.fn.stdpath 'config' .. '/lua/snippets' },
            }
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

    -- Better comments
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        opts = {
            signs = false,
            keywords = {
                FIX = {
                    icon = ' ',
                    color = 'error',
                    alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = ' ', color = 'info' },
                HACK = { icon = ' ', color = 'warning' },
                WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
                PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
                TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
            },
        },
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
            local lint = require 'lint'
            -- NOTE: Skip configuring vscode-eslint and clang-tidy here.
            -- ESLint is already handled in configs/lsp while clangd manages its own linting (clang-tidy).

            --         lint.linters_by_ft = {
            --             javascript = { 'eslint_d' },
            --             typescript = { 'eslint_d' },
            --             javascriptreact = { 'eslint_d' },
            --             typescriptreact = { 'eslint_d' },
            --         }
            --

            -- Autocmd to trigger linting
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    -- Auto-install linters you've referenced in nvim-lint
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

    -- Better bufdelete
    -- {
    --     'echasnovski/mini.bufremove',
    --     event = 'VeryLazy',
    --     version = '*',
    -- },

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

    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
            'DBUIRenameBuffer',
            'DBUILastQueryInfo',
            'DBUIHideNotifications',
        },
        config = function()
            require 'configs.dbui'
        end,
    },

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
