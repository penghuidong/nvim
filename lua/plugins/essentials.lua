return {
    -- 语法高亮
    {'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').setup({
                ensure_installed = { "lua", "go", "cpp", "c", "markdown", "markdown_inline" },
                highlight = { enable = true },
                indent = { enable = true },
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
