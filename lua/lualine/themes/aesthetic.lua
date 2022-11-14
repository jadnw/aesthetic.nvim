local config = require("aesthetic.config")
local palette = require("aesthetic.palette")

local spec = palette.load_spec(config.accent)

local function gen_mode(color)
  return {
    a = { bg = color, fg = spec.bg0, gui = "bold" },
    b = { bg = spec.dark_bg, fg = spec.pal.accent.base },
    c = { bg = spec.dark_bg, fg = spec.fg3 },
  }
end

local aesthetic = {
  normal = gen_mode(spec.pal.accent.base),
  insert = gen_mode(spec.pal.yellow.base),
  command = gen_mode(spec.pal.purple.base),
  visual = gen_mode(spec.pal.magenta.base),
  replace = gen_mode(spec.pal.red.base),
  inactive = gen_mode(spec.fg3),
}

return aesthetic
