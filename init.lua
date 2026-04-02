-- ===================================
-- 核心配置和插件管理器 (LazyVim)
-- ===================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 载入插件配置
require("lazy").setup("plugins", {
    -- 你可以添加一些全局配置选项
})

-- 载入基本设置
require("core.options")
require("core.keymaps")
