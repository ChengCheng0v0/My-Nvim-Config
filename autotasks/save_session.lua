vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("AutoSaveSession", { clear = true }),
    pattern = "*",
    callback = function()
        -- 使用 Session Manager 保存会话
        vim.cmd("SMs first_session")
    end
})

