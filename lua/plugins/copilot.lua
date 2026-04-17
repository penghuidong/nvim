return {
    -- Copilot 核心引擎（补全 + 认证）
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<Tab>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                panel = { enabled = false },
                filetypes = {
                    ["*"] = true,
                },
            })
        end,
    },

    -- Copilot Chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
        },
        build = "make tiktoken",
        config = function()
            require("CopilotChat").setup({
                model = "auto",
                window = {
                    layout = "vertical", -- 垂直分割窗口
                    width = 0.4,         -- 占屏幕 40%
                },
            })

            -- 快捷键
            local map = vim.keymap.set

            -- <leader>cc: 打开 Chat 窗口（Normal 模式对当前行, Visual 模式对选中内容）
            map({ "n", "v" }, "<leader>cc", "<cmd>CopilotChat<CR>",
                { desc = "Copilot Chat" })

            -- <leader>cq: 快速提问（引用当前行/选中内容）
            map({ "n", "v" }, "<leader>cq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
                end
            end, { desc = "Copilot Chat - Quick question" })

            -- <leader>ce: 解释当前行/选中代码
            map({ "n", "v" }, "<leader>ce", "<cmd>CopilotChatExplain<CR>",
                { desc = "Copilot Chat - Explain" })

            -- <leader>cf: 修复当前行/选中代码
            map({ "n", "v" }, "<leader>cf", "<cmd>CopilotChatFix<CR>",
                { desc = "Copilot Chat - Fix" })

            -- <leader>cr: 优化当前行/选中代码
            map({ "n", "v" }, "<leader>cr", "<cmd>CopilotChatOptimize<CR>",
                { desc = "Copilot Chat - Optimize" })
        end,
    },
}
