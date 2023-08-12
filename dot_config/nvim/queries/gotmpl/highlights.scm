; Identifiers

([
    (field)
    (field_identifier)
] @property (#set! priority 105))

((variable) @variable (#set! priority 105))

; Function calls

(function_call
  function: (identifier) @function (#set! priority 105))

(method_call
  method: (selector_expression
    field: (field_identifier) @method) (#set! priority 105))

; Operators

([
    "|"
    ":="
] @operator (#set! priority 105))

; Builtin functions

((identifier) @function.builtin
 (#match? @function.builtin "^(and|call|html|index|slice|js|len|not|or|print|printf|println|urlquery|eq|ne|lt|ge|gt|ge)$")
 (#set! priority 105))

; Delimiters

([
    "."
    ","
] @punctuation.delimiter (#set! priority 105))

([
    "{{"
    "}}"
    "{{-"
    "-}}"
    ")"
    "("
] @punctuation.bracket (#set! priority 105))

; Keywords

([
    "else"
    "else if"
    "if"
    "with"
] @conditional (#set! priority 105))

([
    "range"
    "end"
    "template"
    "define"
    "block"
] @keyword (#set! priority 105))

; Literals

([
  (interpreted_string_literal)
  (raw_string_literal)
  (rune_literal)
] @string (#set! priority 105))

((escape_sequence) @string.special (#set! priority 105))

([
  (int_literal)
  (float_literal)
  (imaginary_literal)
] @number (#set! priority 105))

([
    (true)
    (false)
] @boolean (#set! priority 105))

([
  (nil)
] @constant.builtin (#set! priority 105))

((comment) @comment (#set! priority 105))
((ERROR) @error (#set! priority 105))
