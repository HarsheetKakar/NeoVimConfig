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

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.html", "*.css", "*.json" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

