local function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
end

local oil_filename = require('lualine.components.filename'):extend()

function oil_filename:init(options)
    oil_filename.super.init(self, options)
end

function oil_filename:update_status()
    local data = oil_filename.super.update_status(self)
    if vim.bo.filetype == "oil" then
        local oil_dir = vim.fn.fnamemodify(require("oil").get_current_dir(), ":~")
        data = data:gsub("^" .. literalize(vim.api.nvim_buf_get_name(0)), oil_dir)
        data = data:gsub("^" .. literalize("[No Name]"), oil_dir)
    end
    return data
end

require("lualine").setup {
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { { oil_filename, path = 3 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}
