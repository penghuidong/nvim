return {
    {'iamcco/markdown-preview.nvim',
        build = function() vim.fn["mkdp#util#install"](0) end,
        ft = 'markdown',
        cmd = { 'MarkdownPreview', 'MarkdownPreviewStop' },
    },

    {'plasticboy/vim-markdown',
        ft = 'markdown',
        config = function()
            vim.g.vim_markdown_fenced_languages = {'go=go', 'js=javascript', 'ts=typescript', 'python=python', 'c=c', 'cpp=cpp'}
            vim.g.vim_markdown_frontmatter = true
            vim.g.vim_markdown_new_list_item_indent = 0
        end
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        ft = { 'markdown' },
        opts = {
            heading = {
                enabled = true,
                sign = true,
                icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            },
            code = {
                enabled = true,
                sign = true,
                style = 'full',
                border = 'thin',
            },
            bullet = {
                enabled = true,
                icons = { '●', '○', '◆', '◇' },
            },
            checkbox = {
                enabled = true,
                unchecked = { icon = '󰄱 ' },
                checked = { icon = '󰱒 ' },
            },
            pipe_table = {
                enabled = true,
                style = 'full',
            },
        },
    },
}