return {
    -- 语法高亮
    {'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "lua", "go", "cpp", "c", "markdown", "markdown_inline" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- 补全引擎 (nvim-cmp)
    {'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',         -- LSP 补全源
            'hrsh7th/cmp-buffer',           -- Buffer 补全源
            'hrsh7th/cmp-path',             -- 路径补全源
            'L3MON4D3/LuaSnip',             -- Snippet 引擎
            'saadparwaiz1/cmp_luasnip',     -- Snippet 补全源
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local has_words_before = function()

            end -- 省略函数体，用于 Tab 键判断

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 确认选中项
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end
    },
    
    -- 括号引号自动补全
    {'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true, -- 使用 treesitter 判断上下文，避免在注释/字符串内误触发
            })
            -- 与 nvim-cmp 集成：确认补全时自动补全括号
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
    },

    -- 颜色主题 (VSCode 风格 OneDark)
    {'navarasu/onedark.nvim', 
        config = function() 
            require('onedark').setup({
                style = 'dark', -- 深色风格，类似 VSCode Dark+
                transparent = false,
                term_colors = true,
                ending_tildes = false,
                cmp_itemkind_reverse = false,
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },
            })
            require('onedark').load()
        end
    },

    -- 状态栏 (显示当前文件名等信息)
    {'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'onedark',
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'}, -- 显示当前文件名
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            })
        end
    },

    -- 文件浏览器
    {'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("nvim-tree").setup({
                -- 自动关闭等设置
                view = { width = 30 },
                renderer = { indent_markers = { enable = true }, icons = { glyphs = { folder = { arrow_closed = "→", arrow_open = "↓" } } } },
                actions = { open_file = { quit_on_open = true } },
            })
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
    },

    -- 文件图标
    {'nvim-tree/nvim-web-devicons', lazy = true},
}
