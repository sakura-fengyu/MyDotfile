return {
    "doums/darcula",
    -- "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.cmd([[colorscheme base16-tender]])
        vim.cmd([[colorscheme darcula]])
    end
}
