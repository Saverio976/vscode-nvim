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
    print('error loading lspkind')
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
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            before = function (entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    rg = '[RG]'
                })[entry.source.name]
                return vim_item
            end
        })
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
    },
})

-- add snippets to completions
-- https://github.com/L3MON4D3/LuaSnip
local okluasnip, luasnip = pcall(require, 'luasnip.loaders.from_vscode')
if okluasnip then
    luasnip.lazy_load()
else
    print("can't load luasnip\n")
end

-- vim commands completions
-- https://github.com/gelguy/wilder.nvim
local okwilder, wilder = pcall(require, 'wilder')
if okwilder then
    wilder.setup({modes = {':', '/'}})
    wilder.set_option('pipeline', {
        wilder.branch(
            wilder.cmdline_pipeline(),
            wilder.search_pipeline()
        ),
    })
    wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
            highlights = {
                border = 'Normal',
            },
            highlighter = wilder.basic_highlighter(),
            left = {' ', wilder.popupmenu_devicons()},
            right = {' ', wilder.popupmenu_scrollbar()},
            border = 'rounded',
        })
    ))
end

-- curl cheat.sh to get help
-- https://github.com/RishabhRD/nvim-cheat.sh
vim.g.cheat_default_window_layout = 'tab'
