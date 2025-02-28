-- File: ~/.config/nvim/lua/plugins/emmet.lua

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").emmet_language_server.setup({
                filetypes = {
                    "css",
                    "eruby",
                    "html",
                    "javascript",
                    "javascriptreact", -- for .jsx files
                    "less",
                    "sass",
                    "scss",
                    "pug",
                    "typescriptreact", -- for .tsx files
                    "jsx", -- if needed, alias for JavaScript React files
                },
                init_options = {
                    includeLanguages = {
                        -- Map filetypes to the language Emmet expects (usually "html")
                        javascriptreact = "html",
                        typescriptreact = "html",
                        jsx = "html",
                    },
                    excludeLanguages = {},
                    extensionsPath = {},
                    preferences = {},
                    showAbbreviationSuggestions = true,
                    showExpandedAbbreviation = "always",
                    showSuggestionsAsSnippets = false,
                    syntaxProfiles = {},
                    variables = {},
                },
            })
        end,
    },
}

