-- Define a function ChangeDirectory() which prompts the user to enter a directory path and then changes the current working directory to the given path and opens a file explorer using the :find command.
function RedirectTo()
  local home_dir = vim.fn.expand('~')
  local current_path = vim.fn.getcwd() .. '/'
  local path = vim.fn.input('Find file/folder: ', string.gsub(current_path, home_dir, '~'), 'file')

  if path == '' then
    print('Aborted!')
    return
  end

  local fully_path = home_dir .. string.gsub(path, "~", "")
  vim.cmd("find " .. fully_path)

  -- Use vim.fn.glob() to check if the specified file exists in the directory
  local stat = vim.loop.fs_stat(fully_path)
  if stat then
    if stat.type == "directory" then
      vim.cmd('cd ' .. fully_path)
    end
    print("$", path)
  end
end

-- Set up directory path completion for the function using the wildmenu, wildoptions, and completeopt Vim options.
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- Define the function WildDirectoryPath() which provides autocompletion suggestions for directory paths.
function WildDirectoryPath(arglead, cmdlike, cursorpos)
  if arglead == '' then
    return ''
  end
  local candidates = vim.fn.globpath(vim.fn.getcwd(), arglead .. '*', 1, 1)
  return table.concat(candidates, "\n")
end

-- Set up the completion function for user input using the completefunc Vim option and the <C-x><C-f> key mapping.
vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<C-r>=wildmenumode()<CR><C-x><C-f>', { expr = true })
vim.opt.completefunc = 'v:lua.WildDirectoryPath'

-- Map the <Leader>. key combination in normal mode to the ChangeDirectory() function for easy access.
vim.api.nvim_set_keymap('n', '<leader>.', ':lua RedirectTo()<CR>', { noremap = true, silent = true })
