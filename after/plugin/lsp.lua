local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Read the list of language servers from the file
local servers_file = io.open('lspservers', 'r')
local servers_list = {}

if servers_file then
  for line in servers_file:lines() do
    local server, enabled = line:match('^(%w+)=(%a+)$')

    if server and enabled == 'true' then
      -- servers_list[#servers_list+1] = server
      table.insert(servers_list, server)
    end
  end

  servers_file:close()
end

lsp.ensure_installed(servers_list)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- <CR>
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = { error = "✗", warn = "⚠", hint = "➤", info = "ℹ" },
  -- sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup_servers({
  "tsserver",
  -- "eslint"
})

lsp.format_on_save({
  servers = {
    ["lua_ls"] = { "lua" },
    -- ["astro-ls"] = { "astro" },
    ["rust_analyzer"] = { "rust" },
  },
})

lsp.setup({
  server = 'jdtls',
  config = {
    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },
        sourceFolders = {
          'src',
          'src/com/di4m0nds',
          'src/com/di4m0nds/spawnplugin',
          'src/com/di4m0nds/hologramplugin',
        },
        configuration = {
          runtimes = {
            {
              name = 'JavaSE-1.8',
              path = '/usr/lib/jvm/java-21-openjdk-amd64',
            },
          },
        },
      },
    },
    classpath = { '~/spigot-api/spigot-api-1.20.1.jar' },
  },
})

vim.diagnostic.config({
  virtual_text = true,
})

-- Null-ls Pckg
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.stylua,
    formatting.black.with({ extra_args = { "--fast" } }),
    -- diagnostics.flake8,
    diagnostics.eslint,
  },
})

-- Typescript Pckg
require("typescript").setup({
  server = {
    on_attach = function(client, bufnr)
      -- You can find more commands in the documentation:
      -- https://github.com/jose-elias-alvarez/typescript.nvim#commands

      vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", { buffer = bufnr })
    end,
  },
})

vim.keymap.set("n", "<leader>ls", ":LspInfo<cr>", {})
