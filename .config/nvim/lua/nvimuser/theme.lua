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

local oknvimtree, nvimtree = pcall(require, 'nvim-tree')
if oknvimtree then
    nvimtree.setup({
        disable_netrw = true,
        open_on_setup = true,
        prefer_startup_root = true,
        sync_root_with_cwd = false,
        reload_on_bufenter = true,
        renderer = {
            highlight_git = true,
            indent_markers = {
                enable = true,
            },
        },
        diagnostics = {
            enable = true,
        },
    })
end
