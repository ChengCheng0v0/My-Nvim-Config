vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("AutoSaveSession", { clear = true }),
    pattern = "*",
    callback = function()
        -- 记录当前标签页
        local current_tab = vim.fn.tabpagenr()

        -- 关闭所有 Neotree 窗口
        vim.cmd("tabdo Neotree close")

        -- 关闭所有 Neotree 窗口
        vim.cmd("tabdo MinimapClose")

        -- 回到原来的标签页
        vim.cmd("tabnext " .. current_tab)

        -- 保存会话文件
        vim.cmd("mksession! ~/.local/share/nvim/session.vim")
    end
})

