-- 在无参数启动时自动恢复会话
if vim.fn.argc() == 0 and vim.fn.filereadable(vim.fn.expand("~/.local/share/nvim/session/first_session.vim")) == 1 then
    -- 加载会话文件
    vim.cmd("source ~/.local/share/nvim/session/first_session.vim")
end

vim.defer_fn(function()

    -- 记录当前标签页
    local current_tab = vim.fn.tabpagenr()

    vim.cmd("tabdo lua require('rainbow-delimiters').enable()") -- 在所有标签页中启用彩虹括号
    --vim.cmd("tabdo Neotree") -- 在所有标签页中打开 Neotree

    -- 回到原来的标签页
    vim.cmd("tabnext " .. current_tab)

end, 10) -- 延迟执行以确保插件加载完成

