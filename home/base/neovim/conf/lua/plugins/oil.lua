-- If directory was opened - change cwd to that path once
local bufname = vim.api.nvim_buf_get_name(0)
if vim.fn.isdirectory(bufname) == 1 then
    vim.cmd("cd " .. vim.fn.fnameescape(bufname))
end

require("oil").setup {

}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
