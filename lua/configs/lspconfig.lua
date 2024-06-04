-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- after run :Mason and install jdtls:

-- https://github.com/neovim/nvim-lspconfig
-- :h lspconfig-setup
-- :h vim.lsp.ClientConfig
-- :h vim.lsp.Client
lspconfig.jdtls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- not work:
  --settings = {
  --  java = {
  --    home = "/Users/lex/.sdkman/candidates/java/17.0.10-librca/"
  --  }
  --}
}