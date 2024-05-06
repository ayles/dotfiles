require("toggleterm").setup {
    direction = "float",
    float_opts = {
        border = "rounded",
    },
    hidden = true,
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("t", "<esc><esc>", "<cmd>close<CR>", { silent = true, buffer = term.bufnr })
    end,
    highlights = {
        FloatBorder = {
            link = "FloatBorder",
        },
    },
}

local toggleterm = require("toggleterm")
vim.keymap.set("n", "<leader>a", function() toggleterm.toggle(nil, nil, nil, "float") end, { silent = true })
