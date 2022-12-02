-- completion plugn
-- https://github.com/hrsh7th/nvim-cmp
local okcmp, cmp = pcall(require, 'cmp')
if not okcmp or not cmp then
    return
end
-- add icon to autocompletion
-- https://github.com/onsails/lspkind.nvim
local oklspkind, lspkind = pcall(require, 'lspkind')
if not oklspkind then
    lspkind = {}
    print('error loading lspkind\n')
    function lspkind.cmp_format(_)
        return nil
    end
end
local okcmpunder, cmpunder = pcall(require, 'cmp-under-comparator')
local func_cmp_under
if okcmpunder then
    func_cmp_under = cmpunder.under
else
    func_cmp_under = function (_entry1, _entry2) end
end
local oktabninecmp, tabninecmp = pcall(require, 'cmp_tabnine.compare')
local func_cmp_tabnine
if oktabninecmp then
    func_cmp_tabnine = tabninecmp
else
    func_cmp_tabnine = function (_entry1, _entry2) end
end

local source_mapping = {
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    rg = '[RG]',
    buffer = "[Buffer]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

cmp.setup({
    snippet = {
        expand = function(args)
            local oksnip, luasnip = pcall(require, 'luasnip')
            if oksnip then
                luasnip.lsp_expand(args.body)
            end
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    completion = {
        completopt = 'menuone,preview,noinsert,noselect,'
    },
    sorting = {
        comparators = {
            func_cmp_tabnine,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            func_cmp_under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol_text"})
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        {
            name = 'rg',
            option = {
                additional_arguments = "--max-depth 4 --hidden",
                debounce = 100
            },
            keyword_length = 2
        },
        { name = 'luasnip' },
        {
            name = 'buffer',
            keyword_length = 2,
            get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                    return {}
                end
                return { buf }
            end
        },
        { name = 'cmp_tabnine' }
    },
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})


-- add snippets to completions
-- https://github.com/L3MON4D3/LuaSnip
local okluasnip, luasnip = pcall(require, 'luasnip.loaders.from_vscode')
if okluasnip then
    luasnip.lazy_load()
else
    print("can't load luasnip\n")
end

-- vim commands completions -- this plugin have error with code-minimap
-- https://github.com/gelguy/wilder.nvim
-- local okwilder, wilder = pcall(require, 'wilder')
-- if okwilder then
--     wilder.setup({modes = {':', '/'}})
--     wilder.set_option('pipeline', {
--         wilder.branch(
--             wilder.cmdline_pipeline(),
--             wilder.search_pipeline()
--         ),
--     })
--     wilder.set_option('renderer', wilder.popupmenu_renderer(
--         wilder.popupmenu_palette_theme({
--             highlighter = wilder.basic_highlighter(),
--             left = {' ', wilder.popupmenu_devicons()},
--             right = {' ', wilder.popupmenu_scrollbar()},
--             border = 'rounded',
--             pumblend = 20,
--         })
--     ))
-- end

-- curl cheat.sh to get help
-- https://github.com/RishabhRD/nvim-cheat.sh
vim.g.cheat_default_window_layout = 'tab'

-- completion of keymap
-- https://github.com/folke/which-key.nvim
local okwhichkey, whichkey = pcall(require, 'which-key')
if okwhichkey then
    whichkey.setup({
        registers = true,
    })
end

-- get tabnine (smart) completion
-- https://github.com/tzachar/cmp-tabnine
local oktabnine, tabnine = pcall(require, 'cmp_tabnine.config')
if oktabnine then
    tabnine:setup({
        max_lines = 1000,
        max_num_results = 3,
        sort = true,
        snippet_placeholder = '..',
        show_prediction_strength = true,
    })
end

-- auto pairs () [] {} ...
-- https://github.com/windwp/nvim-autopairs
local okautopairs, autopairs = pcall(require, 'nvim-autopairs')
if okautopairs then
    local del_keymaps = function() -- found at https://github.com/windwp/nvim-autopairs/blob/master/lua/nvim-autopairs.lua#L140
        local status, autopairs_keymaps = pcall(vim.api.nvim_buf_get_var, 0, 'autopairs_keymaps')
        if status and autopairs_keymaps and #autopairs_keymaps > 0 then
            for _, key in pairs(autopairs_keymaps) do
                pcall(vim.api.nvim_buf_del_keymap, 0, 'i', key)
            end
        end
    end
    autopairs.setup({
        enable_check_bracket_line = true,
        ignored_next_char = "[%w%.]",
    })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )
    del_keymaps()
end
