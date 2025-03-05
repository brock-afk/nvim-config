require("config.lazy")

local set = vim.opt

set.number = true
set.relativenumber = true
set.shiftwidth = 4
set.tabstop = 4
set.clipboard = "unnamedplus"
set.mouse = ""
set.expandtab = true

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.have_nerd_font = true

vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.cursorline = true
vim.opt.scrolloff = 15

-- source files
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- map PHP files to .class
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.class",
    command = "set filetype=php"
})

-- map PHP files to .icl
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.icl",
    command = "set filetype=php"
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
