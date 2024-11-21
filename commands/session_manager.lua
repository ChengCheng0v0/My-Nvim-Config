-- 导入 Session Manager
session_manager = require("utils.session_manager")

-- 保存会话
vim.api.nvim_create_user_command("SMs", function(opts)
    session_manager.save_session(opts.args)    
end, {
    nargs = "?"
})

