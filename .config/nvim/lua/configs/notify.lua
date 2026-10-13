local notify = require 'notify'

---@diagnostic disable-next-line: missing-fields
notify.setup {
    background_colour = '#000000',
    timeout = 3000,
    max_width = 65,
    stages = 'static',
    render = 'default',
    top_down = false,
}

-- override vim.notify
vim.notify = notify
