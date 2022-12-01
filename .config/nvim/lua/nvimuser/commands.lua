-- save with ctrl+s
vim.keymap.set('n', '<C-s>', '<CMD>write<CR>', { desc = 'Save' })
vim.keymap.set('i', '<C-s>', '<CMD>write<CR>', { desc = 'Save' })

-- comment/uncomment plugin
-- https://github.com/numToStr/Comment.nvim
local okcomment, comment = pcall(require, 'Comment')
if okcomment then
    comment.setup({
        toggler = {
            line = '<C-:>',
            block = '<C-:>',
        },
        mappings = {
            basic = true,
            extra = false,
        }
    })
end

-- use bd (buffer delete) instead of q (quit)
vim.cmd([[cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'bd' : 'x']])
vim.cmd([[cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'bd' : 'q']])
vim.cmd([[cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? 'write \| bd' : 'wq']])

vim.keymap.set('n', '<C-f>', '/', { desc = 'Search in file' })
vim.keymap.set('i', '<C-f>', '<ESC>/', { desc = 'Search in file' })

vim.keymap.set('n', '<C-p>', '<CMD>Telescope command_palette<CR>', { desc = 'Open command palette' })
vim.cmd([[nmenu PopUp.Command\ Palette <CMD>Telescope command_palette<CR>]])
