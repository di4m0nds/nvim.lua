-- Initialization
local chooseTheme = true
local theme

-- Colors
local teal = "#209999"
local gray = "#808080"
local yellow = "#fcf403"
local jadeGreen = "#04bf59"

local stringColor = { bg = "none", fg = jadeGreen }

local lineNmbr = { bg = "none", fg = gray }
local focusLineNmbr = { bg = "none", fg = yellow }

-- Change Theme
function SetTheme()
  if chooseTheme then
    theme = "gruber-darker"
    chooseTheme = false
  else
    theme = "rose-pine"
    chooseTheme = true
  end

  vim.cmd.colorscheme(theme)

  -- [Customized Theme]
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- Strings
  vim.api.nvim_set_hl(0, "String", stringColor)

  -- Line number
  vim.api.nvim_set_hl(0, "LineNrAbove", lineNmbr)
  vim.api.nvim_set_hl(0, "LineNr", focusLineNmbr)
  vim.api.nvim_set_hl(0, "LineNrBelow", lineNmbr)
end

SetTheme()
