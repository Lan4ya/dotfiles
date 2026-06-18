return {
    { 'nvim-lua/plenary.nvim', event = 'VeryLazy' },

    -- colorscheme
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

    -- {
    --     'stevearc/resession.nvim',
    --     -- event = 'VimEnter',
    --     lazy = false,
    --     dependencies = {
    --         {
    --             'tiagovla/scope.nvim',
    --             lazy = false,
    --             config = true,
    --         },
    --     },
    --     config = function()
    --         require 'configs.resession'
    --     end,
    -- },

    -- session manaager
    {
        'rmagatti/auto-session',
        event = 'VimEnter',
        config = function()
            require 'configs.auto_session'
        end,
    },

    -- {
    --     'akinsho/bufferline.nvim',
    --     event = 'BufReadPost',
    --     version = '*',
    --     config = function()
    --         require 'configs.bufferline'
    --     end,
    -- },

    -- detects a projects indentation style and sets 'shiftwidth', 'tabstop', and 'expandtab' accordingly
    {
        'tpope/vim-sleuth',
        event = { 'BufReadPre', 'BufNewFile' },
    },

    -- auto pair paren, brackets, quotes, etc.
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

    -- git integrations

    {
        'tpope/vim-fugitive',
        cmd = { 'G', 'Git' },
    },
    -- make fugitive cmd's async (not using other feats outside of that)
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
        keys = {
            {
                '<leader>gdo',
                function()
                    local view = require('diffview.lib').get_current_view()
                    if view then
                        vim.cmd 'DiffviewClose'
                    else
                        vim.cmd 'DiffviewOpen'
                    end
                end,
                desc = 'Git Diffview: Toggle',
            },
            -- { '<leader>gdo', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: [O]pen' },
            -- { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = 'Diffview: [C]lose' },
            { '<leader>gdh', '<cmd>DiffviewFileHistory<cr>', desc = 'Git Diffview: File [H]istory' },
            { '<leader>gdf', '<cmd>DiffviewFocusFiles<cr>', desc = 'Git Diffview: [F]ocus Files Sidebar' },
            { '<leader>gdl', '<cmd>DiffviewLog<cr>', desc = 'Git Diffview: [L]og' },
            { '<leader>gdr', '<cmd>DiffviewRefresh<cr>', desc = 'Git Diffview: [R]efresh views' },
            { '<leader>gdt', '<cmd>DiffviewToggleFiles<cr>', desc = 'Git Diffview: [T]oggle Files Sidebar' },
        },
        config = function()
            require 'configs.diffview'
        end,
    },

    -- {
    --     'esmuellert/vscode-diff.nvim',
    --     dependencies = { 'MunifTanjim/nui.nvim' },
    -- },

    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        config = function()
            require 'configs.gitsigns'
        end,
    },

    -- file tree
    {
        'stevearc/oil.nvim',
        opts = {},
        cmd = 'Oil',
    },

    {
        'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        config = function()
            require 'configs.nvim_tree'
        end,
    },

    -- blazingly fast???
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        keys = {
            {
                '<leader>h',
                function()
                    require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
                end,
                desc = 'Harpoon Menu',
            },
            {
                '<leader>.',
                function()
                    require('harpoon'):list():add()
                    vim.cmd 'doautocmd User HarpoonUpdated'
                end,
                desc = 'Harpoon Add',
            },
            {
                '<leader>j',
                function()
                    require('harpoon'):list():select(1)
                    vim.cmd 'doautocmd User HarpoonUpdated'
                end,
                desc = 'Harpoon Jump 1',
            },
            {
                '<leader>k',
                function()
                    require('harpoon'):list():select(2)
                    vim.cmd 'doautocmd User HarpoonUpdated'
                end,
                desc = 'Harpoon Jump 2',
            },
            {
                '<leader>l',
                function()
                    require('harpoon'):list():select(3)
                    vim.cmd 'doautocmd User HarpoonUpdated'
                end,
                desc = 'Harpoon Jump 3',
            },
            {
                '<leader>p',
                function()
                    require('harpoon'):list():select(4)
                    vim.cmd 'doautocmd User HarpoonUpdated'
                end,
                desc = 'Harpoon Jump 4',
            },
        },
        config = function()
            require 'configs.harpoon'
        end,
    },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- no more annoyinng default notif
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

    -- file picker
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
            {
                'nvim-telescope/telescope-live-grep-args.nvim',
            },

            { 'nvim-telescope/telescope-ui-select.nvim' },

            {
                'nvim-telescope/telescope-frecency.nvim',
                version = '*',
            },

            {
                'smartpde/telescope-recent-files',
            },

            {
                'benfowler/telescope-luasnip.nvim',
            },
        },
        config = function()
            require 'configs.telescope'
        end,
    },

    -- snippet engine
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

    -- configures LuaLS for editing neovim
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    -- keymap management
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require 'configs.which_key'
        end,
    },

    -- better comments
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

    {
        'romus204/tree-sitter-manager.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'TSManager' },
        config = function()
            local tsm = require 'tree-sitter-manager'
            tsm.setup {
                ensure_installed = {
                    'bash',
                    'c',
                    'diff',
                    'json',
                    'json5',
                    'html',
                    'css',
                    'ecma',
                    'javascript',
                    'typescript',
                    'jsx',
                    'tsx',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'vim',
                    'vimdoc',
                    'make',
                    'nginx',
                    'sql',
                    'zsh',
                },
                auto_install = true,
                -- border = nil, -- (rounded | single), if nil, use style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
                -- indent = true,
                highlight = true,
            }

            --  tree-sitter-manager highlights by parser-name filetypes (like tsx), but Neovim sets React buffers to typescriptreact / javascriptreact.
            --  So the plugin’s internal FileType autocmd doesn't fire for these two fts.
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'javascriptreact', 'typescriptreact' },
                callback = function(ev)
                    vim.treesitter.start(ev.buf, 'tsx')
                end,
            })
        end,
    },

    -- {
    --     'mfussenegger/nvim-lint',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = function()
    --         local lint = require 'lint'
    --         lint.linters_by_ft = {
    --             javascript = { 'eslint_d' },
    --             typescript = { 'eslint_d' },
    --             javascriptreact = { 'eslint_d' },
    --             typescriptreact = { 'eslint_d' },
    --         }
    --
    --         -- autocmd to trigger linting
    --         vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
    --             callback = function()
    --                 lint.try_lint()
    --             end,
    --         })
    --     end,
    -- },

    -- formatter
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        config = function()
            require 'configs.conform'
        end,
    },

    -- surround, delete around, etc.
    {
        'kylechui/nvim-surround',
        version = '^3.0.0',
        event = 'VeryLazy',
        config = function()
            require 'configs.nvim_surround'
        end,
    },

    -- better loclist && qflist
    {
        'folke/trouble.nvim',
        opts = {}, -- default
        cmd = 'Trouble',
    },

    -- provide bg color on color vals
    {
        'brenoprata10/nvim-highlight-colors',
        event = 'VeryLazy',
        config = function()
            require 'configs.highlight_colors'
        end,
    },

    -- better bufdelete
    -- {
    --     'echasnovski/mini.bufremove',
    --     event = 'VeryLazy',
    --     version = '*',
    -- },

    -- tests
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
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            {
                'MunifTanjim/nui.nvim',
                module = 'nui',
            },
        },
    },
    {
        'toppair/peek.nvim',
        event = { 'VeryLazy' },
        build = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup {
                auto_load = true, -- whether to automatically load preview when
                -- entering another markdown buffer
                close_on_bdelete = true, -- close preview window on buffer delete
                syntax = true, -- enable syntax highlighting, affects performance
                theme = 'dark', -- 'dark' or 'light'
                update_on_change = true,
                app = 'browser', -- 'webview', 'browser', string or a table of strings
                -- explained below
                filetype = { 'markdown' }, -- list of filetypes to recognize as markdown
                -- relevant if update_on_change is true
                throttle_at = 200000, -- start throttling when file exceeds this
                -- amount of bytes in size
                throttle_time = 'auto', -- minimum amount of time in milliseconds
                -- that has to pass before starting new render
            }
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },
    --
    -- {
    --     'folke/noice.nvim',
    --     event = 'VeryLazy',
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'rcarriga/nvim-notify',
    --     },
    --     opts = {
    --         cmdline = {
    --             enabled = true,
    --             view = 'cmdline_popup',
    --             opts = {},
    --             format = {
    --                 search_down = { view = 'cmdline_popup' },
    --                 search_up = { view = 'cmdline_popup' },
    --             },
    --         },
    --         messages = {
    --             enabled = true,
    --         },
    --         popupmenu = {
    --             enabled = true,
    --             backend = 'nui',
    --         },
    --         views = {
    --             cmdline_popup = {
    --                 position = {
    --                     row = '60%',
    --                     col = '50%',
    --                 },
    --                 size = {
    --                     width = 60,
    --                     height = 'auto',
    --                 },
    --             },
    --         },
    --         lsp = {
    --             progress = { enabled = true },
    --             override = {
    --                 ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
    --                 ['vim.lsp.util.stylize_markdown'] = true,
    --                 ['cmp.entry.get_documentation'] = true,
    --             },
    --         },
    --         presets = {
    --             bottom_search = true,
    --             command_palette = true,
    --             long_message_to_split = true,
    --             inc_rename = false,
    --             lsp_doc_border = true,
    --         },
    --     },
    -- },

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
        init = function()
            -- Your dadbod-ui configuration goes here
            vim.g.db_ui_use_nerd_fonts = 1

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'dbui' },
                callback = function()
                    if vim.bo.filetype == 'dbui' then
                        vim.keymap.del('n', 'o', { buffer = true })
                        vim.keymap.del('n', 'S', { buffer = true })
                        vim.keymap.del('n', 'J', { buffer = true })
                        vim.keymap.del('n', 'K', { buffer = true })
                        vim.keymap.del('n', '<C-j>', { buffer = true })
                        vim.keymap.del('n', '<C-k>', { buffer = true })
                        vim.keymap.del('n', '<C-n>', { buffer = true })
                        vim.keymap.del('n', '<C-p>', { buffer = true })

                        vim.keymap.set('n', 's', '<Plug>(DBUI_SelectLine)', { buffer = true, silent = true })
                        vim.keymap.set('n', 'v', '<Plug>(DBUI_SelectLineVsplit)', { buffer = true, silent = true })
                    end
                end,
            })
        end,
    },
}
