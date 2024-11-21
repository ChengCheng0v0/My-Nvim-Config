-- 导入 Session Manager
session_manager = require("utils.session_manager")

-- 保存会话
vim.api.nvim_create_user_command("SMs", function(opts)
    session_manager.save_session(opts.args)
end, {
    nargs = "?"
})

-- 加载会话
vim.api.nvim_create_user_command("SMo", function(opts)
    session_manager.load_session(opts.args, false)
end, {
    nargs = 1
})

-- 深度加载会话
vim.api.nvim_create_user_command("SMO", function(opts)
    session_manager.load_session(opts.args, true)
end, {
    nargs = 1
})

