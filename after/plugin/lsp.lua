local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "lua_ls",
    "rust_analyzer",
})

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
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

lsp.setup_servers({ "tsserver", "eslint" })

lsp.format_on_save({
    servers = {
        ["lua_ls"] = { "lua" },
        ["rust_analyzer"] = { "rust" },
        ["eslint"] = { "javascript", "typescript", "js", "ts" },
    },
})

lsp.setup()

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
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        diagnostics.flake8,
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
