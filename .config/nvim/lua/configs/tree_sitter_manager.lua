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
