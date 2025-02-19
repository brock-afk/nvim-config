return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "ruff", "zls", "intelephense", "rust_analyzer", "eslint" },
            automatic_installation = true,
        })
    end
}
