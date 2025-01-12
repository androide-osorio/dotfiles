local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local none_ls = require("null-ls")

local opts = {
  sources = {
    none_ls.builtins.diagnostics.mypy,
    none_ls.builtins.diagnostics.ruff,
    none_ls.builtins.formatting.black,
  },
  opts = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
}

return opts

