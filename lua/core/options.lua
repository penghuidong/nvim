-- Neovim 基本设置
vim.opt.tabstop = 4         -- Tab 宽度
vim.opt.shiftwidth = 4      -- 自动缩进宽度
vim.opt.expandtab = true    -- 使用空格替代 Tab
vim.opt.number = true       -- 显示行号
vim.opt.relativenumber = false -- 关闭相对行号，只显示绝对行号
vim.opt.splitright = true   -- 垂直分割在新窗口右侧打开
vim.opt.splitbelow = true   -- 水平分割在新窗口下方打开
vim.opt.encoding = 'utf-8'  -- 编码
vim.opt.termguicolors = true -- 启用真彩色
vim.opt.undofile = true     -- 启用撤销文件
vim.opt.ignorecase = true   -- 搜索时忽略大小写
vim.opt.smartcase = true    -- 如果搜索包含大写字母，则开启精确匹配

-- 剪贴板：使用系统剪贴板
vim.opt.clipboard = 'unnamedplus'

-- 默认不折叠
vim.opt.foldenable = false      -- 打开文件时禁用折叠
vim.opt.foldlevel = 99          -- 设置高折叠级别，确保所有代码展开
vim.opt.foldlevelstart = 99     -- 新缓冲区默认全部展开

-- 针对 Go 和 C++ 推荐的设置
vim.opt.formatoptions:remove("o")
vim.opt.textwidth = 100 -- 代码行宽建议

-- 打开文件时跳回上次退出的位置
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})
