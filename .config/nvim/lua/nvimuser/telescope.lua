-- finder, filter, ...
-- https://github.com/nvim-telescope/telescope.nvim
local okteles, telescope = pcall(require, 'telescope')
if not okteles then
    return
end

local actions = require("telescope.actions")

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")

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
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<ESC>"] = actions.close,
            },
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
                { "Save (C-s)", ':write' },
                { "Quit (C-q)", ':bd' },
            },
            {
                "Folder",
                { "Open Tree", ':NvimTreeFocus' },
                { "Close Tree", ':NvimTreeClose' },
            },
            {
                "Find",
                { "File", ':Telescope find_files' },
                { "Pattern in current file", ':call feedkeys("/")' },
                { "Pattern in all files", ':Telescope live_grep' },
            }
            {
                "Terminal",
                { "Toggle (C-=)", ':FloatermToggle', },
                { "New (C-S-²)", ':FloatermNew' },
            },
            {
                "General Command",
                { "Quit Nvim", ':quitall' },
                { "Close Minimap", ':' }
            },
            {
                "Help",
                { "Commands", ':Telescope commands' },
                { "Keymaps", ':Telescope keymaps' },
                { "File Tree Help Toggle", ':NvimTreeFocus | :call feedkeys("g?")' },
                { "Tutorial", ':Tutor' },
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
})
telescope.load_extension('fzf')
telescope.load_extension('command_palette')

-- " Find files using Telescope command-line sugar.
vim.keymap.set('n', 'tf', '<CMD>Telescope find_files<CR>', { desc = 'Telescope find_files', noremap = true, silent = true })
vim.keymap.set('n', 'F', '<CMD>Telescope live_grep<CR>', { desc = 'Telescope live_grep', noremap = true, silent = true })
vim.cmd([[nmenu PopUp.Help:\ Show\ All\ Commands <CMD>Telescope commands<CR>]])
vim.cmd([[nmenu PopUp.Help:\ Show\ All\ KeyMaps <CMD>Telescope keymaps<CR>]])
