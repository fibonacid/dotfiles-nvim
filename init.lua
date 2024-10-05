vim.api.nvim_exec('language en_US', true)

require("config.lazy")

require("nvim-tree").setup()

require("mason").setup()
require("mason-lspconfig").setup {
 ensure_installed = { "ts_ls" }
}

local lspconfig = require("lspconfig")
lspconfig.ts_ls.setup({})
