local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  -- global regular expression print
  builtin.grep_string({ search = vim.fn.input("Grep Search: ") })
end)

vim.keymap.set('n', '<leader>e', builtin.symbols)
