return {
    "neovim/nvim-lspconfig",

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local buf = args.buf
                vim.api.nvim_buf_set_keymap(buf, "n", "<Leader>f", "<cmd>lua vim.lsp.buf.format()<CR>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",
                    { noremap = true, silent = true })
            end,
        })

        require("neodev").setup({})
    end,

    dependencies = {
        {
            "folke/neodev.nvim",
        },

        {
            "williamboman/mason.nvim",
            dependencies = "williamboman/mason-lspconfig.nvim",
            config = function()
                local mason = require("mason")
                local mason_lspconfig = require("mason-lspconfig")
                local lspconfig = require("lspconfig")

                -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                mason.setup({

                })
                mason_lspconfig.setup({})

                lspconfig['pyright'].setup({
                    capabilities = capabilities,
                })

                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },

                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    vim.fn.expand("~/.local/share/nvim/lazy")
                                }
                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            },

                            diagnostics = {
                                globals = { "vim", },
                            },
                        }
                    }
                })
            end

        }
    },

}
