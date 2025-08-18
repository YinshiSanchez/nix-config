vim.g.mapleader = ' '

-- move focus between splits
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true, desc = '移动到左侧分屏' })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true, desc = '移动到下侧分屏' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true, desc = '移动到上侧分屏' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true, desc = '移动到右侧分屏' })
