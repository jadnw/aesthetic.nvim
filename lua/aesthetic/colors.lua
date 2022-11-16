local Color = require("aesthetic.lib.color")

local M = {}

local C = Color:new({
  bg = "#1e282e",
  fg = "#cad5dc",
  factor = 0.25,
})

M.pal = {
  default = {
    black = C:shade("#394c58"),
    red = C:shade("#f77d82"),
    green = C:shade("#8ccf7e"),
    blue = C:shade("#69a6f7"),
    yellow = C:shade("#d8ce91"),
    orange = C:shade("#e3a66d"),
    cyan = C:shade("#70d8ca"),
    teal = C:shade("#54ba9f"),
    magenta = C:shade("#d076b9"),
    purple = C:shade("#ad8bee"),
    white = C:shade("#a0b4c1"),
    comment = "#547182",
    bg0 = "#192126",
    bg1 = "#1e282e",
    bg2 = "#243138",
    bg3 = "#2b3a43",
    bg4 = "#32434d",
    fg0 = "#cad5dc",
    fg1 = "#a0b4c1",
    fg2 = "#8ba4b3",
    fg3 = "#628397",
    sel0 = "#475e6d",
    sel1 = "#2a74ff",
    dark_bg = "#0f1417",
  },
  hard = {
    black = C:shade("#374953"),
    red = C:shade("#f77d82"),
    green = C:shade("#8ccf7e"),
    blue = C:shade("#69a6f7"),
    yellow = C:shade("#d8ce91"),
    orange = C:shade("#e3a66d"),
    cyan = C:shade("#70d8ca"),
    teal = C:shade("#54ba9f"),
    magenta = C:shade("#d076b9"),
    purple = C:shade("#ad8bee"),
    white = C:shade("#c9d5db"),
    comment = "#455c68",
    bg0 = "#161e22",
    bg1 = "#1b2429",
    bg2 = "#222d33",
    bg3 = "#29363e",
    bg4 = "#304048",
    fg0 = "#c9d5db",
    fg1 = "#a9bcc6",
    fg2 = "#89a3b1",
    fg3 = "#7492a3",
    sel0 = "#536e7e",
    sel1 = "#2a74ff",
    dark_bg = "#070a0b",
  },
}

--- Generate spec
-- @param accent string
-- @param pal table
function M.gen_spec(accent, pal)
  local spec = {
    bg0 = pal.bg0, -- Dark bg (status line and float)
    bg1 = pal.bg1, -- Default bg
    bg2 = pal.bg2, -- Lighter bg (colorcolm folds)
    bg3 = pal.bg3, -- Lighter bg (cursor line)
    bg4 = pal.bg4, -- Conceal, border fg

    fg0 = pal.fg0, -- Lighter fg
    fg1 = pal.fg1, -- Default fg
    fg2 = pal.fg2, -- Darker fg (status line)
    fg3 = pal.fg3, -- Darker fg (line numbers, fold colums)

    sel0 = pal.sel0, -- Popup bg, visual selection bg
    sel1 = pal.sel1, -- Popup sel bg, search bg
    dark_bg = pal.dark_bg, -- Lualine bg
  }

  spec.pal = {
    accent = pal[accent],
    black = pal.black,
    red = pal.red,
    green = pal.green,
    blue = pal.blue,
    yellow = pal.yellow,
    orange = pal.orange,
    cyan = pal.cyan,
    teal = pal.teal,
    magenta = pal.magenta,
    purple = pal.purple,
    white = pal.white,
  }

  spec.syntax = {
    attr = pal.yellow.base, -- HTML tag attribues
    bool = pal.orange.base, -- Boolean
    bracket = spec.fg2, -- Brackets and Punctuation
    builtin0 = pal.red.bright, -- Builtin variable
    builtin1 = pal.yellow.base, -- Builtin type
    builtin2 = pal.orange.base, -- Builtin const
    builtin3 = pal.red.base, -- For keywords: return, constructor
    comment = pal.comment, -- Comment
    conditional = pal.magenta.base, -- Conditional and loop
    const = pal.orange.bright, -- Constants, imports and booleans
    constructor = pal.red.bright, -- Constructor, JSX elements
    dep = spec.fg3, -- Deprecated
    field = pal.teal.base, -- Field, Property
    func = pal.blue.base, -- Functions and Titles
    ident = pal.magenta.bright, -- Identifiers
    keyword = pal.purple.base, -- Keywords
    number = pal.orange.bright, -- Numbers
    operator = pal.purple.bright, -- Operators
    param = pal.red.base, -- Params
    preproc = pal.purple.base, -- PreProc
    regex = pal.orange.base, -- Regex
    statement = pal.purple.base, -- Statements
    string = pal.green.base, -- Strings
    delimiter = pal.teal.base, -- Tag delimiter
    type = pal.yellow.base, -- Types
    variable = spec.fg1, -- Variables
  }

  spec.diag = {
    error = pal.red.base,
    warn = pal.yellow.base,
    info = pal.cyan.base,
    hint = pal.green.base,
  }

  spec.diff = {
    add = pal.green.dim,
    delete = pal.red.dim,
    change = pal.yellow.dim,
    text = pal.cyan.dim,
  }

  spec.git = {
    add = pal.cyan.base,
    removed = pal.red.base,
    changed = pal.yellow.base,
    conflict = pal.orange.base,
    ignored = pal.comment,
  }

  return spec
end

return M
