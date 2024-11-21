local stages_util = require("notify.stages.util")

require("notify").setup({
    background_colour = "NotifyBackground",
    fps = 60,
    icons = {
        DEBUG = " ",
        ERROR = " ",
        INFO = " ",
        TRACE = "✎ ",
        WARN = " ",
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = {
        function(state)
            local direction = stages_util.DIRECTION.BOTTOM_UP
            local next_height = state.message.height + 3
            local next_row = stages_util.available_slot(state.open_windows, next_height, direction)
            if not next_row then
                return nil
            end
            return {
                relative = "editor",
                anchor = "NE",
                width = 1,
                height = state.message.height,
                col = vim.opt.columns:get(),
                row = next_row,
                border = "rounded",
                style = "minimal",
            }
        end,
        function(state)
            return {
                width = { state.message.width, frequency = 2 },
                col = { vim.opt.columns:get() },
            }
        end,
        function()
            return {
                col = { vim.opt.columns:get() },
                time = true,
            }
        end,
        function()
            return {
                width = {
                    1,
                    frequency = 2.5,
                    damping = 0.9,
                    complete = function(cur_width)
                        return cur_width < 2
                    end,
                },
                col = { vim.opt.columns:get() },
            }
        end,
    },
    time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
    },
    timeout = 5000,
    top_down = false,
})

-- 消息黑名单
local banned_messages = {
    "[Neo-tree WARN] Invalid mapping for  i :  nil",
    "[Neo-tree WARN] Invalid mapping for  k :  nil"
}

-- 重写通知函数
vim.notify = function(msg, ...)
    for _, banned in ipairs(banned_messages) do
        if msg == banned then
            return
        end
    end
    require("notify")(msg, ...)
end

