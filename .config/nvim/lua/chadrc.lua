---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = 'palenight',
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["@text.literal"] = { italic = true },
    ["@text.reference"] = { italic = true },
    ["@text.title"] = { italic = true },
    ["@text.uri"] = { italic = true },
    ["@string.special"] = { italic = true },
  },
}

M.ui = {
  theme = 'palenight',

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  -- Statusline config
  statusline = {
    theme = "default",
    separator_style = "round",
    overriden_modules = nil,
  },

  -- NvChad tabufline config
  tabufline = {
    enabled = true,
    lazyload = true,
  },
}

return M
