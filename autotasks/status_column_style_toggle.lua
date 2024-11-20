-- 从隔壁那儿借一下隐藏符号列的列表，防止邻里冲突 (lol)
local non_signcolumn_buftypes = require("autotasks.hide_sign_column").non_signcolumn_buftypes

local StatusColumnStyleToggle = vim.api.nvim_create_augroup("StatusColumnStyleToggle", { clear = true })

-- 普通模式
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave" }, {
    group = StatusColumnStyleToggle,
    pattern = "*",
    callback = function()
        if not vim.tbl_contains(non_signcolumn_buftypes, vim.bo.buftype) then
            vim.wo.statuscolumn = "%3r ┇ %s┇  "
            --vim.wo.signcolumn = "yes:3"
        end
    end,
})

-- 插入模式
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = StatusColumnStyleToggle,
    pattern = "*",
    callback = function()
        if not vim.tbl_contains(non_signcolumn_buftypes, vim.bo.buftype) then
            vim.wo.statuscolumn = "%3l ┇ %s┇  "
            --vim.wo.signcolumn = "yes:3"
        end
    end,
})

-- 命令模式
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "CmdlineEnter" }, {
    group = StatusColumnStyleToggle,
    pattern = "*",
    callback = function()
        if not vim.tbl_contains(non_signcolumn_buftypes, vim.bo.buftype) then
            vim.opt.statuscolumn = "%3l ┇ %s┇  "
            --vim.wo.signcolumn = "yes:3"

            vim.cmd("redraw") -- 强制重绘
        end
    end,
})

