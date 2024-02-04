return {
    'hrsh7th/nvim-cmp',

    event = {
        "InsertEnter",
        "CmdlineEnter"
    },

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',         -- LSP Completions
        'hrsh7th/cmp-nvim-lua',         -- Lua Completions
        'hrsh7th/cmp-buffer',           -- Buffer Completions
        'hrsh7th/cmp-path',             -- Path Completions
        'hrsh7th/cmp-cmdline',          -- CommandLine Completions

        "L3MON4D3/LuaSnip",             -- Snippet Engine
        "saadparwaiz1/cmp_luasnip",     -- Snippet Completions

        "rafamadriz/friendly-snippets", -- Bunch of Snippets
        'onsails/lspkind-nvim',
    },

    config = function()
        local cmp = require "cmp"
        local luasnip = require "luasnip"
        local lspkind = require "lspkind"

        require("luasnip.loaders.from_snipmate").lazy_load {}
        require("luasnip.loaders.from_vscode").lazy_load()
        -- require("luasnip.loaders.from_vscode").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets/vscode" }

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            mapping = cmp.mapping.preset.insert {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ---@diagnostic disable-next-line: missing-parameter
                -- Abort auto completion
                ["<C-c>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                },
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                ["<CR>"] = cmp.mapping.confirm { select = false },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },

            formatting = {
                format = lspkind.cmp_format({
                    with_text = true, -- do not show text alongside icons
                    maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    before = function(entry, vim_item)
                        -- Source 显示提示来源
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        return vim_item
                    end
                })
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },

            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            experimental = {
                ghost_text = true,
            },
        }

        cmp.setup.cmdline("/", {
            sources = {
                { name = "buffer" }
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "cmdline" },
                { name = "path" },
            },
            format = lspkind.cmp_format({
                with_text = true, -- do not show text alongside icons
                maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function(entry, vim_item)
                    -- Source 显示提示来源
                    vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                    return vim_item
                end
            })

        })
    end,
}
