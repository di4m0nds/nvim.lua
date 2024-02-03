-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- Themes
  use({ "blazkowolf/gruber-darker.nvim", as = "gruber-darker" })
  use({ "oxfist/night-owl.nvim", as = "night-owl" })
  use { "rose-pine/neovim", as = "rose-pine" }

  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("nvim-treesitter/playground")

  use("theprimeagen/harpoon")

  use("mbbill/undotree")

  use("tpope/vim-fugitive")

  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        run = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    },
  })
  use("jose-elias-alvarez/null-ls.nvim")
  use("jose-elias-alvarez/typescript.nvim")

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  use("ziglang/zig.vim")

  use 'mfussenegger/nvim-jdtls'

  -- Package info (versioning)
  use({
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
  })

  --
  use { "folke/twilight.nvim" }
end)
