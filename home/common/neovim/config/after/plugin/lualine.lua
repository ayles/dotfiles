local function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
end

local oil_filename = require("lualine.components.filename"):extend()

function oil_filename:update_status()
    local data = oil_filename.super.update_status(self)
    if vim.bo.filetype == "oil" then
        local oil_dir = vim.fn.fnamemodify(vim.fs.normalize(require("oil").get_current_dir()), ":~")
        data = data:gsub("^" .. literalize(vim.api.nvim_buf_get_name(0)), oil_dir)
        data = data:gsub("^" .. literalize("[No Name]"), oil_dir)
    end
    return data
end

local oil_filetype = require("lualine.components.filetype"):extend()

function oil_filetype:apply_icon()
    oil_filetype.super.apply_icon(self)
    if vim.bo.filetype == "oil" then
        self.status = " "
    end
end

require("lualine").setup {
    options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { { "mode", separator = { right = ' ', left = '' }, } },
        lualine_b = {},
        lualine_c = {
            {
                oil_filetype,
                icon_only = true,
                padding = { left = 1, right = 0 },
            },
            {
                oil_filename,
                path = 3,
                padding = { left = 0, right = 1 },
                symbols = {
                    modified = "",
                },
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = '󱤅 ', other = '󰠠 ' },
                colored = true,
                padding = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
        require('lualine').refresh()
    end
})
