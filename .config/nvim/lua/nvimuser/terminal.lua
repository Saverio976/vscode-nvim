-- get a beautiful terminal [(n)vim already has one but i like this one]
-- https://github.com/voldikss/vim-floaterm

vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.5
vim.g.floaterm_title = 'Terminal: $1/$2'
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottomright'

vim.g.floaterm_keymap_new = '<C-S-²>'
vim.g.floaterm_keymap_prev = '<C-PageUp>'
vim.g.floaterm_keymap_next = '<C-PageDown>'
vim.g.floaterm_keymap_toggle = '<C-=>'
