([
    "{{"
    "}}"
    "{%"
    "%}"
    "#}"
    "{#"
    (whitespace_control)
] @punctuation.bracket (#set! priority 105))

([
    (startif)
    (else_statement)
    (elif_statement)
    (endif)
    (startmacro)
    (endmacro)
    (set_statement)
    (startfor)
    (endfor)
    (import_statement)
] @conditional (#gmatch! @conditional "{%%%-?%s*()([^ ]*)()") (#set! priority 105))
