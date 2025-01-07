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

-- source files
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.class",
    command = "set filetype=php"
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

local function activate_closest_venv()
    local function find_closest_venv_dir(start_dir)
        local path = vim.fn.fnamemodify(start_dir, ":p")
        while path ~= "/" do
            if vim.fn.isdirectory(path .. "/venv") == 1 then
                return path .. "/venv"
            end
            path = vim.fn.fnamemodify(path, ":h") -- Move up one directory
        end
        return nil
    end

    local closest_venv = find_closest_venv_dir(vim.fn.getcwd())
    if closest_venv then
        local activate_script = closest_venv .. "/bin/activate"
        if vim.fn.filereadable(activate_script) == 1 then
            vim.cmd("let $VIRTUAL_ENV='" .. closest_venv .. "'")
            vim.cmd("let $PATH=join([$VIRTUAL_ENV .. '/bin', $PATH], ':')")
        end
    end
end

activate_closest_venv()

local function activate_poetry_venv()
    if vim.fn.executable("poetry") == 1 then
        local poetry_venv = vim.fn.systemlist("poetry env info -p")[1]
        if poetry_venv and vim.fn.isdirectory(poetry_venv) == 1 then
            vim.cmd("let $VIRTUAL_ENV='" .. poetry_venv .. "'")
            vim.cmd("let $PATH=join([$VIRTUAL_ENV .. '/bin', $PATH], ':')")
        end
    end
end

activate_poetry_venv()
