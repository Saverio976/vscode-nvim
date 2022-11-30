vim.cmd([[au! BufLeave <buffer> if &modified == 1 | write | endif]])
vim.cmd([[au! FocusLost <buffer> if &modified == 1 | write | endif]])

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

vim.cmd([[autocmd BufEnter * EnableBlameLine]])
