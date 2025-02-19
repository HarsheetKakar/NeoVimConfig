-- FilePath: lua/config/autocmds.lua

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- End of line addition
-- Force 'noendofline' globally
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
    pattern = "*",
    callback = function()
        vim.opt.endofline = false
    end,
})

-- Ensure a blank line at the end of the file
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local last_line = vim.api.nvim_buf_get_lines(0, -2, -1, true)[1] or ""
        if last_line:match("^%s*$") == nil then
            vim.api.nvim_buf_set_lines(0, -1, -1, true, { "" })
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.html" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

