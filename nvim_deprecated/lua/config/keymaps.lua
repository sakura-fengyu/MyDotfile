-- 在copy后高亮
vim.api.nvim_create_autocmd(
    { "TextYankPost" },
    {
        pattern = { "*" },
        callback = function() vim.highlight.on_yank({ timeout = 300 }) end
    }
)

-- keybindings
local opt = { noremap = true, silent = false }
vim.keymap.set("n", "<Leader>v", "<C-w>v", opt)
vim.keymap.set("n", "<Leader>s", "<C-w>s", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
-- vim.keymap.set("n", "<Leader>q", ":q<CR>", opt)
vim.keymap.set("n", "<Leader>[", "<C-o>", opt)
vim.keymap.set("n", "<Leader>]", "<C-i>", opt)

-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
vim.keymap.set("n", "j", [[v:count ? 'j' :'gj']], { noremap = true, expr = true })
vim.keymap.set("n", "k", [[v:count ? 'k' :'gk']], { noremap = true, expr = true })

-- global
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

local open_command = 'xdg-open'
if vim.fn.has('mac') == 1 then
    open_command = 'open'
end

local function url_repo()
    local cursorword = vim.fn.expand('<cfile>')
    if string.find(cursorword, '^[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*$') then
        cursorword = 'https://github.com/' .. cursorword
    end
    return cursorword or ''
end

vim.keymap.set('n', 'gx', function()
    vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
end, { silent = true })
