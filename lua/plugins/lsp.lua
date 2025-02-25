-- FilePath: lua/plugins/lsp.lua

return {
    -- Mason for managing LSP servers and tools
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup({
                ui = { border = "rounded" },
            })
        end,
    },

    -- Bridge between Mason and nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls", -- for Bash
                    "gopls", -- for Go
                    "lua_ls", -- for Lua
                    "ts_ls", -- for TypeScript/JavaScript
                    "html", -- for HTML
                    -- "emmet_language_server", -- optionally, for Emmet support
                },
                automatic_installation = true,
            })
        end,
    },

    -- nvim-lspconfig for configuring LSP servers
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
                -- Disable formatting for tsserver if using an external formatter (e.g., via null-ls)
                if client.name == "tsserver" then
                    client.server_capabilities.documentFormattingProvider = false
                end
                -- Additional on_attach logic (keymaps, etc.) can be added here.
            end

            lspconfig.bashls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            lspconfig.gopls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            lspconfig.tsserver.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            lspconfig.html.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })
        end,
    },

    -- null-ls for formatters (shfmt, stylua, and htmlbeautifier)
    -- Uncomment this section if you want to use null-ls for formatting.
    --{
    --    "jose-elias-alvarez/null-ls.nvim",
    --    dependencies = { "nvim-lua/plenary.nvim" },
    --    config = function()
    --        local null_ls = require("null-ls")
    --        null_ls.setup({
    --            sources = {
    --                null_ls.builtins.formatting.shfmt,
    --                null_ls.builtins.formatting.stylua,
    --                null_ls.builtins.formatting.htmlbeautifier,
    --            },
    --        })
    --    end,
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            require("nvim-navic").setup({
                highlight = true,
                separator = " > ",
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true,
            })
        end,
    }, --},
}

