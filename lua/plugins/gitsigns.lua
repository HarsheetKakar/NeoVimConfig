return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                current_line_blame = true, -- show blame info inline
                current_line_blame_opts = {
                    delay = 50, -- delay (ms) before blame info appears
                    virt_text_pos = "eol", -- position of the blame text
                },
                numhl = false, -- highlight line numbers for changed lines
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    -- Navigation for Git hunks
                    vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next Git Hunk" })
                    vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous Git Hunk" })
                    -- Git actions
                    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Git Hunk" })
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Git Hunk" })
                    vim.keymap.set(
                        "n",
                        "<leader>hu",
                        gs.undo_stage_hunk,
                        { buffer = bufnr, desc = "Undo Stage Git Hunk" }
                    )
                    -- Toggle inline blame
                    vim.keymap.set(
                        "n",
                        "<leader>gb",
                        gs.toggle_current_line_blame,
                        { buffer = bufnr, desc = "Toggle Git Blame" }
                    )
                end,
            })
        end,
    },
}

