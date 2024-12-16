vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv',function() vim.cmd('Ex') end)
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
vim.keymap.set('n', '<leader>s', ':source %<cr>')
vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>k', ':q!<cr>')
vim.keymap.set('n', '<F2>', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>t', ':FloatermNew<cr>')

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')
