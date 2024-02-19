-- Initialization
local chooseTheme = 1
local theme

-- Colors
local teal = "#209999"
local gray = "#808080"
local yellow = "#fcf403"
local lightBlue = "#78D6C6"
local jadeGreen = "#04bf59"

local stringColor = { bg = "none", fg = jadeGreen }

local lineNmbr = { bg = "none", fg = gray }
local focusLineNmbr = { bg = "none", fg = yellow }

-- Change Theme
function SetTheme()
  if chooseTheme == 1 then
    theme = "rose-pine"
    focusLineNmbr = { bg = "none", fg = yellow }
    chooseTheme = 2
  elseif chooseTheme == 2 then
    theme = "night-owl"
    focusLineNmbr = { bg = "none", fg = lightBlue }
    chooseTheme = 3
  elseif chooseTheme == 3 then
    theme = "gruber-darker"
    focusLineNmbr = { bg = "none", fg = lightBlue }
    chooseTheme = 1
  end

  vim.cmd.colorscheme(theme)

  -- [Customized Theme]
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- Strings
  -- vim.api.nvim_set_hl(0, "String", stringColor)

  -- Line number
  vim.api.nvim_set_hl(0, "LineNrAbove", lineNmbr)
  vim.api.nvim_set_hl(0, "LineNr", focusLineNmbr)
  vim.api.nvim_set_hl(0, "LineNrBelow", lineNmbr)
end

vim.api.nvim_set_keymap("n", "<leader>th", ":lua SetTheme()<CR>", { noremap = true, silent = true })

SetTheme()
