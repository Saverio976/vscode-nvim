-- save when quit (un-focus) a buffer
vim.cmd([[au! BufLeave <buffer> if &modified == 1 | write | endif]])
vim.cmd([[au! FocusLost <buffer> if &modified == 1 | write | endif]])

-- see lua/nvimuser/autocompletion.lua
local oktabnine, tabnine = pcall(require, 'cmp_tabnine')
if oktabnine then
    local prefetch = vim.api.nvim_create_augroup("prefetch", {clear = true})

    vim.api.nvim_create_autocmd('BufRead', {
        group = prefetch,
        pattern = '*.py,*.ts,*.js,*.c',
        callback = function()
            tabnine:prefetch(vim.fn.expand('%:p'))
        end
    })
end

-- enter in insert mode in modifiable buffer
vim.cmd([[au! BufEnter * if &modifiable == 1 && &buftype != "nofile" && &buftype != "" | startinsert | endif]])
