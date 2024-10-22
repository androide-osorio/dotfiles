---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'palenight',
  statusline = {
    theme = 'default',
    separator_style = 'round',
  }
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
