-- Disable indentscope for specific filetypes
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
    },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

local indentscope = require 'mini.indentscope'

indentscope.setup {
    symbol = '│',
    options = { try_as_border = true },
    draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
    },
}
