-- add some config to default lsp
--https://github.com/neovim/nvim-lspconfig
local oklspconfig, lspconfig = pcall(require, 'lspconfig')
if not oklspconfig then
    print("Could not load lsp\n")
    return
end
local on_attach_ = function (_, bufnr)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
        desc = 'Lsp: Go To Declaration',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
        desc = 'Lsp: Go To Definition',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {
        desc = 'Lsp: Go To Implementation',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', 'gpd', require('goto-preview').goto_preview_definition, {
        desc = 'Lsp: Go To Definition (floating window)',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', 'gpi', require('goto-preview').goto_preview_implementation, {
        desc = 'Lsp: Go To Implementation (floating window)',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {
        desc = 'Lsp: Signature',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, {
        desc = 'Lsp: Add WorkSpace',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, {
        desc = 'Lsp: Remove WorkSpace',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
        desc = 'Lsp: List WorkSpace',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {
        desc = 'Lsp: Type Definition',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {
        desc = 'Lsp: Rename',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {
        desc = 'Lsp: Code Action',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {
        desc = 'Lsp: References',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
    vim.keymap.set('n', '<space>lf', function()
        vim.lsp.buf.format { async = true }
    end, {
        desc = 'Lsp: Format',
        noremap=true,
        silent=true,
        buffer=bufnr
    })
end
local okcmplsp, cmplsp = pcall(require, 'cmp_nvim_lsp')
local cap = nil
if not okcmplsp then
    cap = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end
local function try_setup_server(server, lspconf, on_attach, capabilities)
    lspconf[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local names = {'clangd', 'pyright', 'tsserver'} -- 'pylsp'
for _, lang in ipairs(names) do
    try_setup_server(lang, lspconfig, on_attach_, cap)
end

-- show diagnostics
local oktroubl, trouble = pcall(require, 'trouble')
if oktroubl then
    vim.keymap.set('n', 'gt', '<CMD>TroubleToggle<CR>', {
        desc = 'Lsp: Diagnostics List Toggle',
        noremap=true,
        silent=true
    })
    trouble.setup({
        position = "bottom",
        height = 7,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        indent_lines = true,
        auto_open = false,
        auto_close = true,
        auto_preview = false,
        auto_fold = false,
        signs = {
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠",
        },
        use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
        action_keys = {
            close = 'q',
            cancel = '<ESC>',
            jump = {'<CR>'},
            open_split = {'<C-x>'},
            open_vsplit = {'<C-v>'},
            jump_close = {'<Enter>'},
            hover = 'K',
        },
    })
end

-- go to preview in floating window
-- https://github.com/rmagatti/goto-preview
local okgotopreview, gotopreview = pcall(require, 'goto-preview')
if okgotopreview then
    gotopreview.setup({})
end

-- show progress of lsp actions
-- https://github.com/j-hui/fidget.nvim
local oklsprogress, lsprogress = pcall(require, 'fidget')
if oklsprogress then
    lsprogress.setup({
        window = {
            relative = "editor",
        },
    })
end

-- lightbulb where code action
-- https://github.com/kosayoda/nvim-lightbulb
local oklightbulb, _ = pcall(require, 'nvim-lightbulb')
if oklightbulb then
    vim.cmd([[au! BufEnter * lua require('nvim-lightbulb').update_lightbulb()]])
    vim.cmd([[au! BufWritePost * lua require('nvim-lightbulb').update_lightbulb()]])
    vim.cmd([[au! InsertLeave * lua require('nvim-lightbulb').update_lightbulb()]])
end
