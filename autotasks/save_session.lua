vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("AutoSaveSession", { clear = true }),
    pattern = "*",
    callback = function()
        -- 保存会话
        require("utils.session_manager").save_session("first_session")
    end
})

