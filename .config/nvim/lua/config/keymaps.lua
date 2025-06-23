local keymap = vim.keymap.set

-- Telescope
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<leader>fu', builtin.buffers, { desc = 'Telescope buffers' })
keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

keymap('n', '<leader>fb', ':Telescope file_browser<CR>', { desc = 'File browser' })
keymap('n', '<leader>fB', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = 'File browser (current dir)' })
