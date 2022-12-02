-- For dark theme (neovim's default)
vim.o.background = 'dark'
-- For light theme
-- vim.o.background = 'light'

local okc, c = pcall(require, 'vscode.colors')
if not okc then
    return
end
-- vscode like them
-- https://github.com/Mofiqul/vscode.nvim
require('vscode').setup({
    -- Enable transparent background
    transparent = false,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = false,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})

-- statusline at bottom
-- https://github.com/nvim-lualine/lualine.nvim
local oklualine, lualine = pcall(require, 'lualine')
if oklualine then
    -- inspired by https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua
    lualine.setup({
        options = {
            theme = 'vscode',
            component_separators = '|',
            section_separators = { left = '', right = '' },
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                { 'mode', separator = { left = '' }, right_padding = 2 },
            },
            lualine_b = { 'filename', 'branch' },
            lualine_c = { 'fileformat' },
            lualine_x = {},
            lualine_y = { 'filetype', 'progress' },
            lualine_z = {
                { 'location', separator = { right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    })
end

-- tab at top with file
--https://github.com/akinsho/bufferline.nvim
local okbuferline, buferline = pcall(require, 'bufferline')
if okbuferline then
    buferline.setup({
        options = {
            buffer_close_icon = "",
            close_command = "bdelete %d",
            close_icon = "",
            indicator = { icon = " ", style = 'icon' },
            left_trunc_marker = "",
            modified_icon = "●",
            offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
            right_mouse_command = "bdelete! %d",
            right_trunc_marker = "",
            show_close_icon = false,
            show_tab_indicators = true,
        },
        highlights = {
            fill = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLineNC" },
            },
            background = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            buffer_visible = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            buffer_selected = {
                underline = true,
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            separator = {
                fg = { attribute = "bg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            separator_selected = {
                fg = { attribute = "fg", highlight = "Special" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            separator_visible = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLineNC" },
            },
            close_button = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            close_button_selected = {
                fg = { attribute = "fg", highlight = "normal" },
                bg = { attribute = "bg", highlight = "normal" },
            },
            close_button_visible = {
                fg = { attribute = "fg", highlight = "normal" },
                bg = { attribute = "bg", highlight = "normal" },
            },
        },
    })
end

-- folder tree
-- https://github.com/nvim-tree/nvim-tree.lua
local oknvimtree, nvimtree = pcall(require, 'nvim-tree')
if oknvimtree then
    nvimtree.setup({
        disable_netrw = true,
        open_on_setup = true,
        prefer_startup_root = true,
        sync_root_with_cwd = false,
        reload_on_bufenter = true,
        view = {
            width = 25,
        },
        renderer = {
            highlight_git = true,
            indent_markers = {
                enable = true,
            },
        },
        diagnostics = {
            enable = true,
        },
        update_focused_file = {
            enable = true,
        },
    })
end

-- minimap like vscode
-- https://github.com/wfxr/minimap.vim
vim.g.minimap_highlight_search = 1
vim.g.minimap_git_colors = 1
vim.g.minimap_auto_start = 1
vim.cmd("let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt', 'popup', 'help']")

-- fold block code
-- https://github.com/kevinhwang91/nvim-ufo
local okufo, ufo = pcall(require, 'ufo')
if okufo then
    vim.g.foldcolumn = 1
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Folds: Open All' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Folds: Close All' })
    ufo.setup({
        provider_selector = function(_bufnr, _filetype, _buftype)
            return {'treesitter', 'indent'}
        end,
    })
end

-- language parsing
-- https://github.com/nvim-treesitter/nvim-treesitter
local oktreesitter, treesitter = pcall(require, 'nvim-treesitter.configs')
if oktreesitter then
    treesitter.setup({
        ensure_installed = { "c", "python", "typescript", "javascript", "bash", "lua", "vim" }, -- dont remove 'vim', else you will have bad error, and you dont want to mess with errors
        sync_install = true,
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 1000,
        },
    })
end

-- colorize hexadecimal colors / color name like Red
-- https://github.com/norcalli/nvim-colorizer.lua
local okcolorizer, colorizer = pcall(require, 'colorizer')
if okcolorizer then
    colorizer.setup()
end

-- show indent line
-- lukas-reineke/indent-blankline.nvim
local okindentblank, indentblank = pcall(require, 'indent_blankline')
if okindentblank then
    indentblank.setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
    })
end

-- git sign on left column
-- https://github.com/lewis6991/gitsigns.nvim
local okgit, gitsigns = pcall(require, 'gitsigns')
if okgit then
    gitsigns.setup()
end

-- show git blame per line
-- https://github.com/f-person/git-blame.nvim
vim.g.gitblame_enabled = 1

-- nice config for ui
-- https://github.com/folke/noice.nvim
local oknoice, noice = pcall(require, 'noice')
if oknoice then
    noice.setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
    })
end
