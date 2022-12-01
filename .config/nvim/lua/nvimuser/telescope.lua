-- finder, filter, ...
-- https://github.com/nvim-telescope/telescope.nvim
local okteles, telescope = pcall(require, 'telescope')
if not okteles then
    return
end

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
local file_ignore_pattern = {
    "!**/.git/*",
    "!**/__pycache__/*",
    "!**/node_modules/*",
    "!**/dist/*",
    "!**/.gradle/*",
    "!**/.idea/*",
    "!**/.vscode/*",
    "!**/*.dll",
}

for _, ignored in ipairs(file_ignore_pattern) do
    table.insert(vimgrep_arguments, ignored)
end

telescope.setup({
    defaults = {
        initial_mode = "insert",
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {
            "__pycache__/", "__pycache__/*",
            "node_modules/", "node_modules/*",
            "dist/", "dist/*", "build/", "build/*",
            ".git/", ".git/*",
            ".gradle", ".idea/", ".vscode/",
            ".dll", ".idea/*", ".vscode/*"
        },
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        live_grep = {
            preview = {
                treesitter = false
            }
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            case_mode = 'smart_case'
        },
        command_palette = {
            {
                "File",
                { "Save (C-s)", '<CMD>write<CR>', },
                { "Quit (C-q)", '<CMD>bd<CR>', },
                { "Find File", '<CMD>Telescope find_files<CR>' },
            },
            {
                "Help",
                { "Commands", '<CMD>Telescope commands<CR>', },
                { "Keymaps", '<CMD>Telescope keymaps<CR>', },
                { "File Tree Help Toggle", '<CMD>NvimTreeFocus | call feedkeys("g?")<CR>', },
                { "Tutorial", '<CMD>Tutor<CR>', },
            },
            {
                "Terminal",
                { "Toggle (C-=)", '<CMD>FloatermToggle<CR>', },
                { "New (C-S-²)", '<CMD>FloatermNew<CR>' },
            }
        },
    },
    pickers = {
        pickers = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
})
telescope.load_extension('fzf')
telescope.load_extension('command_palette')

-- " Find files using Telescope command-line sugar.
vim.keymap.set('n', 'tf', '<CMD>Telescope find_files<CR>', { desc = 'Telescope find_files', noremap = true, silent = true })
vim.keymap.set('n', '<S-f>', '<CMD>Telescope live_grep<CR>', { desc = 'Telescope live_grep', noremap = true, silent = true })
vim.cmd([[nmenu PopUp.Help:\ Show\ All\ Commands <CMD>Telescope commands<CR>]])
vim.cmd([[nmenu PopUp.Help:\ Show\ All\ KeyMaps <CMD>Telescope keymaps<CR>]])
