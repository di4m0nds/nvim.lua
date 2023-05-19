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

-- Resizes window
-- -- Resize window vertically
function RWV(size, direction) -- ex: RWV(5, -1) | RWV(5, 1)
  local current_win = vim.api.nvim_get_current_win()
  local current_size = vim.api.nvim_win_get_height(current_win)
  local new_size = current_size + (size * direction)
  vim.api.nvim_win_set_height(current_win, new_size)
end

-- -- Resize window horizontally
function RWH(size, direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_size = vim.api.nvim_win_get_width(current_win)
  local new_size = current_size + (size * direction)
  vim.api.nvim_win_set_width(current_win, new_size)
end

-- Function to replace the old string with the new string on the selected lines
function replace_visual_selection_only()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Construct the input message with the start and end line numbers
  local input_message = string.format(":<LS,LE><%d,%d>{{replace_strs}}/", start_line, end_line)
  local input = vim.fn.input(input_message)

  if input == '' then
    print('Aborted!')
    return
  end

  -- Extract old_string and new_string from the input using pattern matching
  local old_string, new_string = input:match("([^/]+)/([^/]+)")

  for line = start_line, end_line do
    -- Get the content of the current line
    local line_content = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]

    -- Replace the pattern with the replacement string
    local new_content = line_content:gsub(old_string, new_string)

    -- Update the line with the new content
    vim.api.nvim_buf_set_lines(bufnr, line - 1, line, false, { new_content })
  end
end
