return {
    cmd = "Telescope",
    keys = {
        { "<Leader>p", ":Telescope find_files<CR>", desc = "find file" },
        { "<Leader>P", ":Telescope live_grep<CR>",  desc = "grep file" },
        { "<Leader>r", ":Telescope resume<CR>",     desc = "resume" },
        { "<Leader>q", ":Telescope oldfiles<CR>",   desc = "oldfiles" },
    },
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
}
