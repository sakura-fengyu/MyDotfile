-- ################################################################################
-- #                                                                              #
-- #                              TREE SITTER                                     #
-- #                      NOTE: Btter text hightlighting                          #
-- #                                                                              #
-- ################################################################################
return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            custom_captures = {
                -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                ["foo.bar"] = "Identifier",
            },

            hightlight = {
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,

                enable = true,
                -- disable = function(_, buf)
                --     local max_filesize = 100 * 1024 -- 100 KB
                --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                --     if ok and stats and stats.size > max_filesize then
                --         return true
                --     end
                -- end,
            },

            modules = {
            },

            ensure_installed = {
                "lua",
            },

            ignore_install = {},

            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil  -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            },

            indent = { enable = true, disable = {} },

            sync_install = false,

            auto_install = false,

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>", -- set to `false` to disable one of the mappings
                    node_incremental = "<CR>",
                    scope_incremental = "<BS>",
                    node_decremental = "<TAB>",
                },
            },

        })
    end,
}
