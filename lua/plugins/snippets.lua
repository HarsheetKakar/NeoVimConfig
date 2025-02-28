return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets", -- Contains a wide collection of snippets, including React
        },
        config = function()
            -- Load VSCode-style snippets (which include React snippets)
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}

