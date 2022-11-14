local palette = require("aesthetic.palette")
local group = require("aesthetic.group")
local highlight = require("aesthetic.lib.highlight")

local M = {}

function M.colorscheme()
  local config = require("aesthetic.config")
  local spec = palette.load_spec(config.accent, config.style)
  local hls = group.get_highlights(spec, config)
  highlight.hl(hls)

  if config.options.terminal_colors then
    highlight.set_terminal_colors(spec)
  end
end

function M.setup(user_conf)
  local config = require("aesthetic.config")
  config.set(user_conf)
end

return M
