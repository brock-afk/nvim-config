return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require("lspconfig").lua_ls.setup { capabilities = capabilities }
            require("lspconfig").zls.setup { capabilities = capabilities }
            require("lspconfig").rust_analyzer.setup {
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false,
                        }
                    }
                }
            }
            -- code action key maps
            vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
            vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
            vim.keymap.set('n', 'grr', vim.lsp.buf.references)
            vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })


            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if not client then return end


                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })
        end,
    } }
