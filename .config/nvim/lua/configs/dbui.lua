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
