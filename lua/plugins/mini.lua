-- FilePath: lua/plugins/neo-tree.lua

return {
    "echasnovski/mini.nvim",
    version = "*", -- Always use the latest version
    config = function()
        -- Essential modules
        require("mini.ai").setup() -- Enhanced text objects
        require("mini.align").setup() -- Interactive alignment
        require("mini.comment").setup() -- Comment toggling
        require("mini.surround").setup() -- Surround actions (add, change, delete)

        -- Appearance modules
        require("mini.indentscope").setup({
            symbol = "│", -- Customize indent scope symbol
            options = { try_as_border = true },
        })

        -- General workflow modules
        require("mini.bufremove").setup() -- Remove buffers without closing windows
    end,
}

