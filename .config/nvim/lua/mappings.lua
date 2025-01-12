require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Telescope mappings
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP List Symbols" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP List References" })
map("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP List Definitions" })
map("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP List Implementations" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find Keymaps" })

-- Git pickers
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git Commits" })
map("n", "<leader>gB", "<cmd>Telescope git_bcommits<CR>", { desc = "Git Commits for Buffer" })
map("n", "<leader>gz", "<cmd>Telescope git_stash<CR>", { desc = "Git List Stashes" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git List Branches" })

-- DAP mappings
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dus", function()
    local widgets = require("dap.ui.widgets")
    local sidebar = widgets.sidebar(widgets.scopes)
    sidebar.open()
end, { desc = "Open debugging sidebar" })

-- DAP Python mappings
map("n", "<leader>dpr", function()
    require('dap-python').test_method()
end, { desc = "Test Python Method" })

-- Crates mappings
map("n", "<leader>rcu", function()
    require("crates").upgrade_all_crates()
end, { desc = "Upgrade all crates" })
