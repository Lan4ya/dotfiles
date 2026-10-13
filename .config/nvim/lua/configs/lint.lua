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
