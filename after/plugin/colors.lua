local chooseTheme = true

function SetTheme()
  local theme

  if chooseTheme then
    theme = "gruber-darker"
    chooseTheme = false
  else
    theme = "rose-pine"
    chooseTheme = true
  end

  vim.cmd.colorscheme(theme)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "String", { bg = "none", fg = "#626cff" })
end

SetTheme()
