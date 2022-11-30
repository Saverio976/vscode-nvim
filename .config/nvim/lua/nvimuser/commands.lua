vim.keymap.set('n', '<C-s>', '<CMD>write<CR>', { desc = 'Save' })
vim.keymap.set('i', '<C-s>', '<CMD>write<CR>', { desc = 'Save' })

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

vim.cmd([[cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'bd' : 'x']])
vim.cmd([[cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'bd' : 'q']])
vim.cmd([[cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? 'write \| bd' : 'wq']])
