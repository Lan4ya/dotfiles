local theme = require 'lualine.themes.oxide'
for _, mode in ipairs { 'normal', 'insert', 'visual', 'replace', 'command', 'inactive', 'terminal' } do
    theme[mode].c.bg = 'NONE'
end

require('lualine').setup {
    options = {
        theme = theme,
        component_separators = '',
        section_separators = '',
    },

    sections = {
        lualine_a = {},
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = {
            -- Harpoon files
            {
                function()
                    local has_harpoon, harpoon = pcall(require, 'harpoon')
                    if not has_harpoon then
                        return ''
                    end
                    local list = harpoon:list()
                    local items = list.items

                    if #items == 0 then
                        return ''
                    end

                    local result = {}
                    for i = 1, math.min(4, #items) do
                        local item = items[i]
                        if item and item.value then
                            local filename = vim.fn.fnamemodify(item.value, ':t')
                            table.insert(result, filename)
                        end
                    end

                    return table.concat(result, ' | ')
                end,
                color = function()
                    local has_harpoon, harpoon = pcall(require, 'harpoon')
                    if not has_harpoon then
                        return 'Comment'
                    end
                    local list = harpoon:list()
                    if #list.items > 0 then
                        return nil
                    else
                        return 'Comment'
                    end
                end,
            },
            -- Copilot status
            {
                function()
                    return '󰚩'
                end,
                color = function()
                    local ok, api = pcall(require, 'copilot.api')
                    if not ok then
                        return 'Comment'
                    end

                    local status = api.status.data and api.status.data.status
                    if status == 'InProgress' or status == 'Normal' then
                        return nil
                    end
                    return 'Comment'
                end,
            },
            -- LSP status
            {
                function()
                    return '󰒋'
                end,
                color = function()
                    local clients = vim.lsp.get_clients { bufnr = 0 }
                    if #clients > 0 then
                        return nil
                    else
                        return 'Comment'
                    end
                end,
            },
            -- Formatter status
            {
                function()
                    return '󰉣'
                end,
                color = function()
                    local has_conform, conform = pcall(require, 'conform')
                    if not has_conform then
                        return 'Comment'
                    end
                    local formatters = conform.list_formatters(0)
                    if #formatters > 0 then
                        return nil
                    else
                        return 'Comment'
                    end
                end,
            },
            -- Linter status
            {
                function()
                    return '󰁨'
                end,
                color = function()
                    local has_lint, lint = pcall(require, 'lint')
                    if not has_lint then
                        return 'Comment'
                    end
                    local linters = lint.linters_by_ft[vim.bo.filetype] or {}
                    if #linters > 0 then
                        return nil
                    else
                        return 'Comment'
                    end
                end,
            },
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { 'mason' },
}
