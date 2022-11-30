-- guess indent if open file
-- https://github.com/Darazaki/indent-o-matic
local okindentomatic, indentomatic = pcall(require, 'indent-o-matic')
if okindentomatic then
    indentomatic.setup({
        max_lines = 2048,
        standard_widths = { 2, 4, 8 },
        skip_multiline = true,
    })
end
