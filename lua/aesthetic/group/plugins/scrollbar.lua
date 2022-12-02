-- https://github.com/petertriho/nvim-scrollbar

local M = {}

function M.get(spec, config, opts)
  local pal = spec.pal
  local syn = spec.syntax
  local diag = spec.diag

  return {
    ScrollbarHandle = { fg = spec.fg0, bg = syn.comment },
    ScrollbarCursorHandle = { fg = pal.accent.base, bg = pal.accent.base },
    ScrollbarCursor = { fg = spec.fg0, bg = syn.comment },

    ScrollbarSearchHandle = { fg = spec.sel1, bg = spec.bg1 },
    ScrollbarSearch = { fg = spec.sel1, bg = spec.bg1 },
    ScrollbarErrorHandle = { fg = diag.error, bg = spec.bg1 },
    ScrollbarError = { fg = diag.error, bg = spec.bg1 },
    ScrollbarWarnHandle = { fg = diag.warn, bg = spec.bg1 },
    ScrollbarWarn = { fg = diag.warn, bg = spec.bg1 },
    ScrollbarInfoHandle = { fg = diag.info, bg = spec.bg1 },
    ScrollbarInfo = { fg = diag.info, bg = spec.bg1 },
    ScrollbarHintHandle = { fg = diag.hint, bg = spec.bg1 },
    ScrollbarHint = { fg = diag.hint, bg = spec.bg1 },
    ScrollbarMiscHandle = { fg = spec.fg0, bg = spec.bg1 },
    ScrollbarMisc = { fg = spec.fg0, bg = spec.bg1 },

    ScrollbarGitAddHandle = { fg = spec.git.add, bg = spec.bg1 },
    ScrollbarGitAdd = { fg = spec.git.add, bg = spec.bg1 },
    ScrollbarGitChangeHandle = { fg = spec.git.changed, bg = spec.bg1 },
    ScrollbarGitChange = { fg = spec.git.changed, bg = spec.bg1 },
    ScrollbarGitDeleteHandle = { fg = spec.git.removed, bg = spec.bg1 },
    ScrollbarGitDelete = { fg = spec.git.removed, bg = spec.bg1 },
  }
end

return M
