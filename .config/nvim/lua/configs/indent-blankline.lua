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

require('ibl').setup {
    indent = {
        highlight = { 'RainbowRed', 'RainbowYellow', 'RainbowBlue', 'RainbowOrange', 'RainbowGreen', 'RainbowViolet', 'RainbowCyan' },
        char = '│',
        tab_char = '│',
    },
    scope = {
        enabled = false,
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
}
