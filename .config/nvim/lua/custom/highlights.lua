local transparent_bg_group = {
    'Normal',
    'NormalNC',
    'NormalFloat',
    'FloatBorder',
    'Pmenu',
    'TelescopeNormal',
    'TelescopeBorder',
    'SignColumn',
    'StatusLine',
    'TabLine',
    'TabLineFill',
    'TabLineSel',
    'WinSeparator',
    'CursorLine',
    'EndOfBuffer',
}

local set_hl = vim.api.nvim_set_hl

-- Backgrounds
for _, group in ipairs(transparent_bg_group) do
    set_hl(0, group, { bg = 'none' })
end

set_hl(0, 'LineNr', { fg = '#555555' })
set_hl(0, 'CursorLineNr', { fg = '#e0e0e0', bold = true })
set_hl(0, 'WinSeparator', { fg = '#303030' })
set_hl(0, 'FloatBorder', { fg = '#3b4252' })
set_hl(0, 'ModeMsg', { fg = '#d19a66' })
set_hl(0, 'MiniIndentscopeSymbol', { fg = '#2E3440' })
-- BlinkCmpMenuBorder xxx guifg=

if vim.g.colors_name == 'nord' then
end
