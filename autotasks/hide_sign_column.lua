-- 需要隐藏符号列的缓冲区 (缓冲区类型)
local non_signcolumn_buftypes = {
    "nofile",
    "neo-tree",
    "neo-tree-popup",
    "minimap",
    "terminal",
}

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("HideSignColumn", { clear = true }),
    pattern = "*",
    callback = function()
        -- 默认显示符号列
        if vim.bo.buftype == "" then
            vim.wo.signcolumn = "yes:3"
            vim.wo.statuscolumn = "%3r ┇ %s┇  "
        -- 对指定类型的缓冲区隐藏符号列
        elseif vim.tbl_contains(non_signcolumn_buftypes, vim.bo.buftype) then
            vim.wo.signcolumn = "no"
            vim.wo.statuscolumn = ""
        end
    end,
})

-- 导出部分变量以供其它模块使用
return {
    non_signcolumn_buftypes = non_signcolumn_buftypes,
}

