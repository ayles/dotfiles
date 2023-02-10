vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    virtual_text = false,
}

local signs = {
    Error = "● ",
    Warn = "● ",
    Info = "● ",
    Hint = "● ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

