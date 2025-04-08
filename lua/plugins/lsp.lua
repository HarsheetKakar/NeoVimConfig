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
                    "ts_ls", -- for JavaScript/React/TypeScript
                    "html", -- for HTML
                    "emmet_language_server", -- optionally, for Emmet support via LSP
                    "basedpyright",
                    "volar",
                    -- Remove angular-language-server here if you prefer to configure Angular LS manually
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
                -- Disable formatting for ts_ls if using an external formatter (null-ls)
                if client.name == "ts_ls" then
                    client.server_capabilities.documentFormattingProvider = false
                end
                -- Additional on_attach logic (keymaps, etc.) can be added here.
            end
            -- Vue
            lspconfig.volar.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
                filetypes = { "vue", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                -- additional settings if needed
            })
            -- Bash
            lspconfig.bashls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            -- Go
            lspconfig.gopls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            -- Lua
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

            -- JavaScript/React/TypeScript via ts_ls
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                settings = {
                    javascript = {
                        inlayHints = {
                            parameterNames = { enabled = "none" },
                            parameterTypes = { enabled = false },
                            functionLikeReturnTypes = { enabled = false },
                            variableTypes = { enabled = false },
                        },
                    },
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "none" },
                            parameterTypes = { enabled = false },
                            functionLikeReturnTypes = { enabled = false },
                            variableTypes = { enabled = false },
                        },
                    },
                },
            })

            -- HTML
            lspconfig.html.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            -- Angular Language Server (configured manually, without Mason)
            lspconfig.angularls.setup({
                on_attach = on_attach,
                cmd = { "ngserver", "--stdio" },
                filetypes = { "html", "typescript", "typescriptreact", "javascript", "javascriptreact" },
                root_dir = lspconfig.util.root_pattern("angular.json", ".git"),
                single_file_support = false,
            })
            -- Pyright with basic type checking (BasedPyright)
            lspconfig.basedpyright.setup({
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic", -- "basic" mode (less strict than "strict")
                        },
                    },
                    basedpyright = {
                        analysis = {
                            inlayHints = {
                                variableTypes = true, -- Show inlay hints for variable assignments (default true)
                                callArgumentNames = true, -- Show inlay hints for function arguments (default true)
                                functionReturnTypes = true, -- Show inlay hints for function return types (default true)
                                genericTypes = true, -- Show inlay hints for inferred generic types (default false)
                            },
                        },
                    },
                },
            })
        end,
    },

    -- null-ls for formatters (shfmt, stylua, and Prettier for JS/React)
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.shfmt,
                    require("null-ls").builtins.formatting.stylua,
                    require("null-ls").builtins.formatting.prettier.with({
                        extra_args = { "--tab-width", "4" },
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "typescript",
                            "typescriptreact",
                            "html",
                            "css",
                            "json",
                        },
                    }),
                },
            })
        end,
    },

    -- nvim-navic for code context (breadcrumbs)
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
    },
}

