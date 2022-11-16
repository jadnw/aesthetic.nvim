local M = {}

function M.new_group()
  --@diagnostic disable-next-line: undefined-field
  return not vim.treesitter.highlighter.hl_map
end

function M.get(spec, config, opts)
  return M.fallback(spec, config, opts)
end

function M.fallback(spec, config, opts)
  local syn = spec.syntax
  local stl = config.styles

  local fallback_groups = {
  -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
  ["annotation"] = {
    "TSAnnotation",
    { link = "PreProc" },
  },
  -- HTML/JSX attributes
  ["attribute"] = {
    "TSAttribute",
    { fg = syn.attr },
  },
  -- Boolean literals: `True` and `False` in Python.
  ["boolean"] = {
    "TSBoolean",
    { link = "Boolean" },
  },
  -- Character literals: `'a'` in C.
  ["character"] = {
    "TSCharacter",
    { link = "Character" },
  },
  -- Special characters
  ["character.special"] = {
    "TSCharacterSpecial",
    { link = "SpecialChar" },
  },
  ["comment"] = {
    "TSComment",
    { link = "Comment" },
  },
  ["conditional"] = {
    "TSConditional",
    { link = "Conditional" },
  },
  ["constant"] = {
    "TSConstant",
    { link = "Constant" },
  },
  ["constant.builtin"] = {
    "TSConstBuiltin",
    { fg = syn.builtin2, style = stl.constants },
  },
  ["constant.macro"] = {
    "TSConstMacro",
    { link = "Define" },
  },
  ["constructor"] = {
    "TSConstructor",
    { fg = syn.constructor },
  },
  ["debug"] = {
    "TSDebug",
    { link = "Debug" },
  },
  ["define"] = {
    "TSDefine",
    { link = "Define" },
  },
  ["error"] = {
    "TSError",
    { link = "Error" },
  },
  ["exception"] = {
    "TSException",
    { link = "Exception" },
  },
  ["field"] = {
    "TSField",
    { fg = syn.field },
  },
  ["float"] = {
    "TSFloat",
    { link = "Float" },
  },
  ["function"] = {
    "TSFunction",
    { link = "Function" },
  },
  ["function.call"] = {
    "TSFunctionCall",
    { link = "Function" },
  },
  ["function.builtin"] = {
    "TSFuncBuiltin",
    { fg = syn.builtin0, style = stl.functions },
  },
  ["function.macro"] = {
    "TSFuncMacro",
    { fg = syn.builtin0, style = stl.functions },
  },
  ["include"] = {
    "TSInclude",
    { link = "Include" },
  },
  ["keyword"] = {
    "TSKeyword",
    { link = "Keyword" },
  },
  ["keyword.function"] = {
    "TSKeywordFunction",
    { fg = syn.builtin0, style = stl.functions },
  },
  ["keyword.operator"] = {
    "TSKeywordOperator",
    { link = "Operator" },
  },
  ["keyword.return"] = {
    "TSKeywordReturn",
    { fg = syn.builtin0, style = stl.keywords },
  },
  ["label"] = {
    "TSLabel",
    { link = "Label" },
  },
  ["method"] = {
    "TSMethod",
    { link = "Function" },
  },
  ["method.call"] = {
    "TSMethodCall",
    { link = "Function" },
  },
  ["namespace"] = {
    "TSNamespace",
    { fg = syn.builtin1 },
  },
  ["none"] = {
    "TSNone",
    { link = "Boolean" },
  },
  ["number"] = {
    "TSNumber",
    { link = "Number" },
  },
  ["operator"] = {
    "TSOperator",
    { link = "Operator" },
  },
  ["parameter"] = {
    "TSParameter",
    { fg = syn.builtin0, style = stl.parameters }
  },
  ["parameter.reference"] = {
    "TSParameterReference",
    { link = "@parameter" },
  },
  ["preproc"] = {
    "TSPreProc",
    { link = "PreProc" },
  },
  ["property"] = {
    "TSProperty",
    { link = "@field" },
  },
  ["punctuation.delimiter"] = {
    "TSPunctDelimiter",
    { fg = syn.bracket },
  },
  ["punctuation.bracket"] = {
    "TSPunctBracket",
    { link = "@punctuation.delimiter" },
  },
  ["punctuation.special"] = {
    "TSPunctSpecial",
    { link = "@punctuation.delimiter" },
  },
  ["repeat"] = {
    "TSRepeat",
    { link = "Repeat" },
  },
  ["storageclass"] = {
    "TSStorageClass",
    { link = "StorageClass" },
  },
  ["string"] = {
    "TSString",
    { link = "String" },
  },
  ["string.regex"] = {
    "TSStringRegex",
    { fg = syn.regex },
  },
  ["string.escape"] = {
    "TSStringEscape",
    { link = "Operator" },
  },
  ["string.special"] = {
    "TSStringSpecial",
    { link = "Operator" },
  },
  ["symbol"] = {
    "TSSymbol",
    { link = "Identifier" },
  },
  ["tag"] = {
    "TSTag",
    { link = "Label" },
  },
  ["tag.attribute"] = {
    "TSTagAttribute",
    { link = "@attribute" },
  },
  ["tag.delimiter"] = {
    "TSTagDelimiter",
    { link = "Delimiter" },
  },
  ["text"] = {
    "TSText",
    { fg = syn.variable }
  },
  ["text.strong"] = {
    "TSStrong",
    { fg = syn.variable, style = "bold" },
  },
  ["text.emphasis"] = {
    "TSEmphasis",
    { fg = syn.variable, style = "italic" },
  },
  ["text.underline"] = {
    "TSUnderline",
    { fg = syn.variable, style = "underline" },
  },
  ["text.strike"] = {
    "TSStrike",
    { fg = syn.variable, style = "strikethrough" },
  },
  ["text.title"] = {
    "TSTitle",
    { link = "Title" },
  },
  ["text.literal"] = {
    "TSLiteral",
    { link = "String" },
  },
  ["text.uri"] = {
    "TSURI",
    { link = "Underlined" },
  },
  ["text.math"] = {
    "TSMath",
    { link = "Special" },
  },
  ["text.reference"] = {
    "TSTextReference",
    { link = "Constant" },
  },
  ["text.environment"] = {
    "TSEnvironment",
    { link = "Macro" },
  },
  ["text.environment.name"] = {
    "TSEnvironmentName",
    { link = "Type" },
  },
  ["text.note"] = {
    "TSNote",
    { link = "SpecialComment" },
  },
  ["text.warning"] = {
    "TSWarning",
    { link = "Todo" },
  },
  ["text.danger"] = {
    "TSDanger",
    { link = "Error" },
  },
  ["todo"] = {
    "TSTodo",
    { link = "Todo" },
  },
  ["type"] = {
    "TSType",
    { link = "Type" },
  },
  ["type.builtin"] = {
    "TSTypeBuiltin",
    { fg = syn.builtin1, style = stl.types },
  },
  ["type.qualifier"] = {
    "TSTypeQualifier",
    { link = "Indentifier" },
  },
  ["type.definition"] = {
    "TSTypeDefinition",
    { link = "Type" },
  },
  ["variable"] = {
    "TSVariable",
    { fg = syn.variable, style = stl.variables },
  },
  ["variable.builtin"] = {
    "TSVariableBuiltin",
    { fg = syn.builtin0, style = stl.variables },
  },
  ['field.rust'] = {
    "rustTSField",
    { fg = spec.fg2 },
  },
  ["tag.javascript"] = {
    nil,
    { fg = syn.builtin0 },
  },
  ["tag.typescript"] = {
    nil,
    { fg = syn.builtin0 },
  },
}

  local groups = {}
  if M.new_group() then
    for k, v in pairs(fallback_groups) do
      groups["@" .. k] = v[2]
    end
  else
    for _, v in pairs(fallback_groups) do
      groups[v[1]] = v[2]
    end
  end


  return groups
end

return M
