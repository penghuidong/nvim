-- 通用快捷键映射
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- leader 键
vim.g.mapleader = " "

-- 窗口操作
map("n", "<leader>sv", ":vsplit<CR>", opts) -- 垂直分割
map("n", "<leader>sh", ":split<CR>", opts)  -- 水平分割
map("n", "<C-h>", "<C-w>h", opts)          -- 窗口切换
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- 退出
map("n", "<leader>q", ":q<CR>", opts) -- 关闭当前窗口/缓冲区

-- 缓冲区操作 (Buffer)
map("n", "<leader>bn", ":bn<CR>", opts) -- 切换到下一个 buffer
map("n", "<leader>bp", ":bp<CR>", opts) -- 切换到上一个 buffer
map("n", "<leader>bd", ":bd<CR>", opts) -- 关闭当前 buffer

-- Markdown
map("n", "<leader>mp", ":MarkdownPreview<CR>", opts)
map("n", "<leader>ms", ":MarkdownPreviewStop<CR>", opts)
