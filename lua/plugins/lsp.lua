return {
    -- 更好的 finder UI
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({})
        end
    },

    -- LSP 配置管理
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',      -- LSP, Formatter, Linter 的安装管理
            'williamboman/mason-lspconfig.nvim', -- mason 和 lspconfig 的集成
        },
        config = function()
            local lspconfig = require('lspconfig')
            local mason_lspconfig = require('mason-lspconfig')

            -- Lsp 快捷键 (可自定义)
            -- 设置全局快捷键，这样即使 LSP 未激活也能响应
            local opts_lsp = { noremap = true, silent = true }
            vim.keymap.set('n', 'gd', function()
                if vim.lsp.buf.definition then vim.lsp.buf.definition()
                else vim.notify("LSP not attached", vim.log.levels.WARN) end
            end, opts_lsp) -- 定义跳转
            vim.keymap.set('n', 'gD', function()
                if vim.lsp.buf.declaration then vim.lsp.buf.declaration()
                else vim.notify("LSP not attached", vim.log.levels.WARN) end
            end, opts_lsp) -- 声明跳转
            vim.keymap.set('n', 'gi', function()
                if vim.lsp.buf.implementation then vim.lsp.buf.implementation()
                else vim.notify("LSP not attached", vim.log.levels.WARN) end
            end, opts_lsp) -- 实现跳转
            vim.keymap.set('n', 'gr', function()
                if vim.lsp.buf.references then
                    vim.lsp.buf.references()
                else
                    vim.notify("LSP not attached", vim.log.levels.WARN)
                end
            end, opts_lsp) -- 查找引用

            local on_attach = function(client, bufnr)
                -- 其他缓冲区本地快捷键保持不变
                local buf_set_keymap = vim.api.nvim_buf_set_keymap
                buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts_lsp)          -- 悬浮文档
                buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts_lsp) -- 重命名
                buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts_lsp) -- 代码操作
            end

            -- 通过 LspAttach 事件注册格式化，比 on_attach 更可靠
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
                        end,
                    })
                end,
            })
            
            -- 安装 LSP 服务器
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            -- 使用 Mason 来设置 LSP 服务器
            mason_lspconfig.setup {
                ensure_installed = { "gopls", "clangd", "lua_ls" },
                -- 默认配置所有通过 Mason 安装的 LSP
                handlers = {
                    function (server_name)
                        lspconfig[server_name].setup {
                            on_attach = on_attach,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            settings = {} -- 服务器特定设置
                        }
                    end,

                    -- Go 语言 gopls 特殊配置
                    ["gopls"] = function()
                        lspconfig.gopls.setup {
                            on_attach = on_attach,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            -- 优先查找 go.work，再回退到 go.mod，确保多模块项目正常工作
                            root_dir = require('lspconfig.util').root_pattern("go.work", "go.mod", ".git"),
                            -- 使用系统已安装的gopls，避免mason网络问题
                            cmd = { "/home/damonpeng/go/bin/gopls" },
                            settings = {
                                gopls = {
                                    completeUnimported = true,
                                    staticcheck = true,
                                    gofumpt = true,
                                },
                            },
                        }
                    end,

                    -- C/C++ clangd 特殊配置
                    ["clangd"] = function()
                        lspconfig.clangd.setup {
                            on_attach = on_attach,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            cmd = {
                                "clangd",
                                "--header-insertion=iwyu", -- 改进头文件插入
                                "--background-index",      -- 启用后台索引
                            },
                            -- 针对 C++ 项目，建议使用 compile_commands.json
                            -- 确保在项目根目录生成 compile_commands.json 文件 (通过 CMake 等工具)
                        }
                    end,
                }
            }
        end
    },
}
