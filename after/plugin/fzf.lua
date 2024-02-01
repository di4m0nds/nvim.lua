local cmd = vim.cmd

-- Key mapping to open the buffer list with fzf
-- <leader>bl: Leader key + 'bl' opens the buffer list
vim.api.nvim_set_keymap('n', '<leader>bl', ':Buffers<CR>', { noremap = true, silent = true })

-- Key mapping to open the command-line history with fzf
-- <leader>bh: Leader key + 'bh' opens the command-line history
vim.api.nvim_set_keymap('n', '<leader>bh', ':History<CR>', { noremap = true, silent = true })

-- Key mapping to open the command-line history with fzf, including commands with ":" prefix
-- <leader>ch: Leader key + 'ch' opens the command-line history, including ":" prefix
vim.api.nvim_set_keymap('n', '<leader>ch', ':History:<CR>', { noremap = true, silent = true })

-- Key mapping to search and open files in the project with fzf
-- <leader>ff: Leader key + 'ff' opens the file search using fzf
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true, silent = true })

-- Key mapping to browse Git commits with fzf
-- <leader>cm: Leader key + 'cm' opens the Git commit history with fzf
vim.api.nvim_set_keymap('n', '<leader>cm', ':Commits<CR>', { noremap = true, silent = true })


-- Exclude node_modules in :Files command
cmd [[
  command! -bang -nargs=* -complete=dir Files
        \ call fzf#vim#files(<q-args>,
        \ {'source': 'rg --files --hidden --follow --glob "!.git/*" --glob "!.svn/*" --glob "!node_modules/*"'})
]]
