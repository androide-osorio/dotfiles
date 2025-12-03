-- Load NvChad defaults for LSP
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Common configuration shared across all LSP servers
local common_config = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Configure individual LSP servers using the new vim.lsp.config() API
-- Reference: https://github.com/neovim/nvim-lspconfig

-- HTML
vim.lsp.config("html", common_config)

-- CSS
vim.lsp.config("cssls", vim.tbl_extend("force", common_config, {
  filetypes = { "css", "scss", "less" },
}))

-- Lua (for Neovim config development)
vim.lsp.config("lua_ls", vim.tbl_extend("force", common_config, {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua",
        },
      },
    },
  },
}))

-- Python
vim.lsp.config("pyright", vim.tbl_extend("force", common_config, {
  filetypes = { "python" },
}))

-- Rust
vim.lsp.config("rust_analyzer", vim.tbl_extend("force", common_config, {
  filetypes = { "rust" },
}))

-- Enable all configured LSP servers
vim.lsp.enable({
  "html",
  "cssls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
})
