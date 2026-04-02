return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('gitsigns').setup({
            -- 行尾实时显示 blame（默认关闭，可用 <leader>gB 手动切换）
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 显示在行尾
                delay = 500,           -- 延迟 500ms 显示，避免频繁刷新
                ignore_whitespace = false,
            },
            current_line_blame_formatter = ' <author>, <author_time:%Y-%m-%d> · <summary>',

            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },

            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = function(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- 跳转到上/下一个 hunk
                map('n', ']c', gs.next_hunk, 'Next hunk')
                map('n', '[c', gs.prev_hunk, 'Prev hunk')

                -- 手动触发当前行 blame 详情（浮窗显示完整信息）
                map('n', '<leader>gb', gs.blame_line, 'Blame line')

                -- 切换行尾 blame 显示开关
                map('n', '<leader>gB', gs.toggle_current_line_blame, 'Toggle line blame')
            end,
        })
    end,
}
