return {
    -- 格式化工具支持
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    markdown = { "prettier" },
                },
                -- 保存时自动格式化
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = true,
                },
            })

            -- 可以手动触发格式化: <leader>f
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 3000,
                })
            end, { desc = "Format file or range" })
        end,
    },
}
