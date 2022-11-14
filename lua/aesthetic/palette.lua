local M = {}

M.accents = {
  orange = "orange",
  teal = "teal",
  white = "white",
  cyan = "cyan",
  green = "green",
  magenta = "magenta",
  purple = "purple",
  red = "red",
  blue = "blue",
  yellow = "yellow",
}

M.styles = {
  "default",
  "hard",
}

function M.load_spec(accent, style)
  accent = vim.tbl_contains(vim.tbl_keys(M.accents), accent) and accent or "green"
  style = vim.tbl_contains(M.styles, style) and style or "default"
  local colors = require("aesthetic.colors")
  return colors.gen_spec(M.accents[accent], colors.pal[style])
end

return M
