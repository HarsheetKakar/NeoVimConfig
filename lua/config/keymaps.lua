--  FilePath: nvim/lua/config/keymaps.luakey

-- Add custom keymaps under <leader>z for all your configurations

-- Keybinding to re-indent the entire file
vim.keymap.set("n", "<leader>zif", "<cmd>IndentFile<CR>", {
    desc = "Re-indent the entire file",
})

-- Keybinding to add a commented file path at the top of the file
vim.keymap.set("n", "<leader>zafn", "<cmd>InsertFilePathComment<CR>", {
    desc = "Add commented file path at the start",
})

-- Keybinding to copy the entire file contents to the clipboard
vim.keymap.set("n", "<leader>zcef", function()
    local cursor_pos = vim.fn.getpos(".") -- Save current cursor position
    vim.cmd('normal! ggVG"+y') -- Select all and copy to clipboard
    vim.fn.setpos(".", cursor_pos) -- Restore cursor position
end, {
    desc = "Copy entire file to clipboard",
})

-- Keybinding to clear the entire file contents
vim.keymap.set("n", "<leader>zclf", "<cmd>ClearFileContents<CR>", {
    desc = "Clear the entire file contents",
})

vim.keymap.set("n", "<leader>zsef", "<cmd>SelectEntireFile<CR>", {
    desc = "Select entire file contents",
})

vim.keymap.set("n", "<leader>zcdm", "<cmd>CopyDiagnosticMessage<CR>", {
    desc = "Copy Diagnostic Message to Clipboard",
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

local function smart_toggle_tree()
    local api = vim.api
    local current_win = api.nvim_get_current_win()
    local current_buf = api.nvim_win_get_buf(current_win)
    local ft = vim.bo[current_buf].filetype

    -- If currently in the file tree window, close it and return focus to previous window.
    if ft == "neo-tree" then
        -- vim.cmd("Neotree close")
        -- Give focus back to the previously active window.
        vim.cmd("wincmd p")
        return
    end

    -- Check if any window already has the file tree open.
    local tree_win = nil
    for _, win in ipairs(api.nvim_list_wins()) do
        local buf = api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "neo-tree" then
            tree_win = win
            break
        end
    end

    if tree_win then
        -- If tree is open, switch focus to it.
        api.nvim_set_current_win(tree_win)
    else
        -- If tree is not open, open it.
        vim.cmd("Neotree show")
    end
end

-- Map <leader>e to this smart toggle function.
vim.keymap.set("n", "<leader>e", smart_toggle_tree, { desc = "Smart toggle file explorer (like VSCode Ctrl+Shift+E)" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Global search in current directory" })

-- Map leader + b and leader + n to previous cursor position and next cursor position respectively
vim.keymap.set("n", "<leader>b", "<C-o>", { desc = "Jump to previous location" })
vim.keymap.set("n", "<leader>n", "<C-i>", { desc = "Jump to next location" })

-- Harpoon configurautions
vim.keymap.set("n", "<leader>a", function()
    require("harpoon.mark").add_file()
end, { desc = "Add file to Harpoon" })
vim.keymap.set("n", "<leader>h", function()
    require("harpoon.ui").toggle_quick_menu()
end, { desc = "Toggle Harpoon quick menu" })

-- Harpoon navigations
vim.keymap.set("n", "<A-1>", function()
    require("harpoon.ui").nav_file(1)
end, { desc = "Go to Harpoon file 1" })
vim.keymap.set("n", "<A-2>", function()
    require("harpoon.ui").nav_file(2)
end, { desc = "Go to Harpoon file 2" })
vim.keymap.set("n", "<A-3>", function()
    require("harpoon.ui").nav_file(3)
end, { desc = "Go to Harpoon file 3" })
vim.keymap.set("n", "<A-4>", function()
    require("harpoon.ui").nav_file(4)
end, { desc = "Go to Harpoon file 4" })

-- LSP Keybinding

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

-- Map <leader>qq to call this function
function _G.confirm_quit_all()
    -- Get all buffers
    local bufs = vim.api.nvim_list_bufs()
    -- Loop through buffers to find an unsaved one
    for _, bufnr in ipairs(bufs) do
        local info = vim.fn.getbufinfo(bufnr)[1]
        if info and info.changed == 1 and info.name ~= "" then
            -- Switch to the unsaved buffer to bring it into view
            vim.api.nvim_set_current_buf(bufnr)
            break
        end
    end
    -- Use the built-in confirm command, which will prompt for confirmation
    vim.cmd("confirm qa")
end
vim.keymap.set("n", "<leader>qq", confirm_quit_all, { desc = "Quit all (confirm unsaved buffers)" })

-- Switch between linter errors in a file
vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Go to next error" })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Go to previous error" })

-- Diagnostics toggle
vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, { desc = "Toggle diagnostics globally" })

-- Get type info
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })

-- Rename a variable in scope
vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

