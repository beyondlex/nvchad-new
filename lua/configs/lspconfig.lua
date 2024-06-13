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
-- below code is moved to plugins/init.lua (https://github.com/nvim-java/nvim-java/issues/103#issuecomment-2035826620)
-- lspconfig.jdtls.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--
--   -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- https://github.com/nvim-java/nvim-java?tab=readme-ov-file#method-2
--   settings = {
--     java = {
--       configuration = {
--         runtimes = {
--           name = "JavaSE-17",
--           path = "/Users/lex/.sdkman/candidates/java/17.0.10-librca/",
--           default = true,
--         }
--       }
--     }
--   }
-- }
