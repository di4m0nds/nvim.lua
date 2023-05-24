require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,      -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false,        -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = 2,       -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
  start_in_insert = true,
  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
  direction = "tab",        -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true,     -- close the terminal window when the process exits
  -- Change the default shell. Can be a string or a function returning a string
  shell = vim.o.shell,
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    winblend = 0,
  },
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- Function change terminal direction
local TERMINAL_DIRECTON = "tab"

function SetTerminalDirection()
  local direction = vim.fn.input("Terminal direction (h: horizontal, v: vertical, t: tab, f: float): ")
  if direction == "h" then
    TERMINAL_DIRECTON = "horizontal"
  elseif direction == "v" then
    TERMINAL_DIRECTON = "vertical"
  elseif direction == "t" then
    TERMINAL_DIRECTON = "tab"
  elseif direction == "f" then
    TERMINAL_DIRECTON = "float"
  else
    print("Invalid direction. Please choose one of the provided options.")
  end
end

-- Function to run a command in the terminal
function RunCommandInTerminal()
  local compileCommand = vim.fn.input("Compile command: ")

  if compileCommand == "" then
    print("Aborted!")
    return
  end

  local term = require("toggleterm.terminal").Terminal
  local cmd = term:new({
    direction = TERMINAL_DIRECTON,
    hidden = true,
    close_on_exit = true,
  })
  cmd:toggle()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(compileCommand .. "<CR>", true, false, true), "n", true)
end

vim.keymap.set("n", "<leader>cc", ":lua RunCommandInTerminal()<CR>", { silent = true })
