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
