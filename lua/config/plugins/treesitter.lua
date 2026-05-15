return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- The new version explicitly requires lazy = false
        build = ":TSUpdate",
        config = function()
            -- Modern nvim-treesitter uses require('nvim-treesitter').setup
            require('nvim-treesitter').setup({
                -- Directory to install parsers and queries to
                install_dir = vim.fn.stdpath('data') .. '/site'
            })

            -- Install your preferred language parsers asynchronously
            require('nvim-treesitter').install({
                "lua", "vim", "vimdoc", "rust", "zig", "python", "php", "toml", "yaml", "json", "odin"
            })

            -- Global autocommand to automatically start tree-sitter highlighting on file open
            vim.api.nvim_create_autocmd('FileType', {
                pattern = '*',
                callback = function(args)
                    local buf = args.buf
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name == "" then return end

                    -- Clean modern filesize limit check
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, name)
                    if ok and stats and stats.size > max_filesize then
                        return -- Skip highlighting for huge files
                    end

                    -- Natively starts core Neovim treesitter engine
                    pcall(vim.treesitter.start, buf)
                end,
            })
        end
    }
}
