-- 切换 RenderMarkdown 的 开启/关闭 状态
vim.api.nvim_create_user_command("RMT", function()
    require("render-markdown").toggle()
end, {
    nargs = 0
})

