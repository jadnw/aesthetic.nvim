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
  -- Line comments and block comments.
  ["comment"] = {
    "TSComment",
    { link = "Comment" },
  },
  -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
  ["conditional"] = {
    "TSConditional",
    { link = "Conditional" },
  },
  -- Constants identifiers. These might not be semantically constant.  E.g. uppercase variables in Python.
  ["constant"] = {
    "TSConstant",
    { link = "Constant" },
  },
  -- Built-in constant values: `nil` in Lua.
  ["constant.builtin"] = {
    "TSConstBuiltin",
    { fg = syn.builtin2, style = stl.constants },
  },
  -- Constants defined by macros: `NULL` in C.
  ["constant.macro"] = {
    "TSConstMacro",
    { link = "Define" },
  },
  -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
  ["constructor"] = {
    "TSConstructor",
    { fg = syn.constructor },
  },
  -- For keyword like `debugger`
  ["debug"] = {
    "TSDebug",
    { link = "Debug" },
  },
  -- For `#define` in C/C++
  ["define"] = {
    "TSDefine",
    { link = "Define" },
  },
  -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
  ["error"] = {
    "TSError",
    { link = "Error" },
  },
  -- Exception related keywords: `try`, `except`, `finally` in Python.
  ["exception"] = {
    "TSException",
    { link = "Exception" },
  },
  -- Object and struct fields.
  ["field"] = {
    "TSField",
    { fg = syn.field },
  },
  -- Floating-point number literals.
  ["float"] = {
    "TSFloat",
    { link = "Float" },
  },
  -- Function definitions.
  ["function"] = {
    "TSFunction",
    { link = "Function" },
  },
  -- Function calls
  ["function.call"] = {
    "TSFunctionCall",
    { link = "Function" },
  },
  -- Built-in functions: `print` in Lua.
  ["function.builtin"] = {
    "TSFuncBuiltin",
    { fg = syn.builtin0, style = stl.functions },
  },
  -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
  ["function.macro"] = {
    "TSFuncMacro",
    { fg = syn.builtin0, style = stl.functions },
  },
  -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
  ["include"] = {
    "TSInclude",
    { link = "Include" },
  },
  -- Keywords that don't fit into other categories.
  ["keyword"] = {
    "TSKeyword",
    { link = "Keyword" },
  },
  -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
  ["keyword.function"] = {
    "TSKeywordFunction",
    { fg = syn.builtin0, style = stl.functions },
  },
  -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
  ["keyword.operator"] = {
    "TSKeywordOperator",
    { link = "Operator" },
  },
  -- Keywords like `return` and `yield`.
  ["keyword.return"] = {
    "TSKeywordReturn",
    { fg = syn.builtin0, style = stl.keywords },
  },
  -- GOTO labels: `label:` in C, and `::label::` in Lua.
  ["label"] = {
    "TSLabel",
    { link = "Label" },
  },
  -- Method definitions.
  ["method"] = {
    "TSMethod",
    { link = "Function" },
  },
  -- Method calls
  ["method.call"] = {
    "TSMethodCall",
    { link = "Function" },
  },
  -- Identifiers referring to modules and namespaces.
  ["namespace"] = {
    "TSNamespace",
    { fg = syn.builtin1 },
  },
  -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
  ["none"] = {
    "TSNone",
    { fg = spec.fg3 },
  },
  -- Numeric literals that don't fit into other categories.
  ["number"] = {
    "TSNumber",
    { link = "Number" },
  },
  -- Binary or unary operators: `+`, and also `->` and `*` in C.
  ["operator"] = {
    "TSOperator",
    { link = "Operator" },
  },
  -- Parameters of a function.
  ["parameter"] = {
    "TSParameter",
    { fg = syn.builtin0, style = stl.parameters }
  },
  -- References to parameters of a function.
  ["parameter.reference"] = {
    "TSParameterReference",
    { link = "@parameter" },
  },
  -- Preprocessors
  ["preproc"] = {
    "TSPreProc",
    { link = "PreProc" },
  },
  -- Same as `@field`.
  ["property"] = {
    "TSProperty",
    { link = "@field" },
  },
  -- Punctuation delimiters: Periods, commas, semicolons, etc.
  ["punctuation.delimiter"] = {
    "TSPunctDelimiter",
    { fg = syn.bracket },
  },
  -- Brackets, braces, parentheses, etc.
  ["punctuation.bracket"] = {
    "TSPunctBracket",
    { link = "@punctuation.delimiter" },
  },
  -- Special punctuation that doesn't fit into the previous categories.
  ["punctuation.special"] = {
    "TSPunctSpecial",
    { link = "@punctuation.delimiter" },
  },
  -- Keywords related to loops: `for`, `while`, etc.
  ["repeat"] = {
    "TSRepeat",
    { link = "Repeat" },
  },
  -- Same as 'StorageClass'
  ["storageclass"] = {
    "TSStorageClass",
    { link = "StorageClass" },
  },
  -- String literals.
  ["string"] = {
    "TSString",
    { link = "String" },
  },
  -- Regular expression literals.
  ["string.regex"] = {
    "TSStringRegex",
    { fg = syn.regex },
  },
  -- Escape characters within a string: `\n`, `\t`, etc.
  ["string.escape"] = {
    "TSStringEscape",
    { link = "Operator" },
  },
  -- Strings with special meaning that don't fit into the previous categories.
  ["string.special"] = {
    "TSStringSpecial",
    { link = "Operator" },
  },
  -- Strings with special meaning that don't fit into the previous categories.
  ["symbol"] = {
    "TSSymbol",
    { link = "Identifier" },
  },
  -- Tags like HTML tag names.
  ["tag"] = {
    "TSTag",
    { link = "Label" },
  },
  -- HTML tag attributes.
  ["tag.attribute"] = {
    "TSTagAttribute",
    { link = "@attribute" },
  },
  -- Tag delimiters like `<` `>` `/`.
  ["tag.delimiter"] = {
    "TSTagDelimiter",
    { link = "Delimiter" },
  },
  -- Non-structured text. Like text in a markup language.
  ["text"] = {
    "TSText",
    { fg = syn.variable }
  },
  -- Text to be represented in bold.
  ["text.strong"] = {
    "TSStrong",
    { fg = syn.variable, style = "bold" },
  },
  -- Text to be represented with emphasis.
  ["text.emphasis"] = {
    "TSEmphasis",
    { fg = syn.variable, style = "italic" },
  },
  -- Text to be represented with an underline.
  ["text.underline"] = {
    "TSUnderline",
    { fg = syn.variable, style = "underline" },
  },
  -- Strikethrough text.
  ["text.strike"] = {
    "TSStrike",
    { fg = syn.variable, style = "strikethrough" },
  },
  -- Text that is part of a title.
  ["text.title"] = {
    "TSTitle",
    { link = "Title" },
  },
  -- Literal or verbatim text.
  ["text.literal"] = {
    "TSLiteral",
    { link = "String" },
  },
  -- URIs like hyperlinks or email addresses.
  ["text.uri"] = {
    "TSURI",
    { link = "Underlined" },
  },
  -- Math environments like LaTeX's `$ ... $`
  ["text.math"] = {
    "TSMath",
    { link = "Special" },
  },
  -- Footnotes, text references, citations, etc.
  ["text.reference"] = {
    "TSTextReference",
    { link = "Constant" },
  },
  -- Text environments of markup languages.
  ["text.environment"] = {
    "TSEnvironment",
    { link = "Macro" },
  },
  -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
  ["text.environment.name"] = {
    "TSEnvironmentName",
    { link = "Type" },
  },
  -- Text representation of an informational note.
  ["text.note"] = {
    "TSNote",
    { link = "SpecialComment" },
  },
  -- Text representation of a warning note.
  ["text.warning"] = {
    "TSWarning",
    { link = "Todo" },
  },
  -- Text representation of a danger note.
  ["text.danger"] = {
    "TSDanger",
    { link = "Error" },
  },
  -- Same as `Todo`
  ["todo"] = {
    "TSTodo",
    { link = "Todo" },
  },
  -- Type (and class) definitions and annotations.
  ["type"] = {
    "TSType",
    { link = "Type" },
  },
  -- Built-in types: `i32` in Rust.
  ["type.builtin"] = {
    "TSTypeBuiltin",
    { fg = syn.builtin1, style = stl.types },
  },
  -- Type but what is qualifier?
  ["type.qualifier"] = {
    "TSTypeQualifier",
    { link = "Indentifier" },
  },
  -- Type (and class) definitions
  ["type.definition"] = {
    "TSTypeDefinition",
    { link = "Type" },
  },
  -- Variable names that don't fit into other categories.
  ["variable"] = {
    "TSVariable",
    { fg = syn.variable, style = stl.variables },
  },
  -- Variable names defined by the language: `this` or `self` in Javascript.
  ["variable.builtin"] = {
    "TSVariableBuiltin",
    { fg = syn.builtin0, style = stl.variables },
  },
  -- Object fields in Rust
  ['field.rust'] = {
    "rustTSField",
    { fg = spec.fg2 },
  },
  -- JSX tag opening/closing element
  ["tag.javascript"] = {
    nil,
    { fg = syn.builtin0 },
  },
  -- TSX tag opening/closing element
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
