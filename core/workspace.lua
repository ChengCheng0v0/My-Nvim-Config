-- 在无参数启动时自动恢复会话
if vim.fn.argc() == 0 and vim.fn.filereadable(vim.fn.expand("~/.local/share/nvim/session.vim")) == 1 then
    -- 加载会话文件
    vim.cmd("source ~/.local/share/nvim/session.vim")
end

--[[
-- 在所有标签页中打开 Neotree
vim.defer_fn(function()
    vim.cmd("tabdo Neotree")
end, 10) -- 延迟执行以确保插件加载完成
--]]

