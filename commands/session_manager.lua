-- 模块名
local module_name = "Session Manager"
local module_format_name = "[Session Manager]"
local module_format_name_endspace = "[Session Manager] "
-- 会话保存路径
local session_path = "~/.local/share/nvim/session"

-- Flags
local flag = {
    no_name = false -- 未指定保存文件名
}

-- 保存会话
vim.api.nvim_create_user_command("SMs", function(opts)
    -- 如果未指定保存文件名则使用预设文件名
    if opts.args == "" then
        flag.no_name = true -- 更新 Flag

        local file_name = nil
        local time = os.date("%Y-%m-%d_%H:%M")
        local id = 1

        -- 获取同时间的文件列表
        local same_time_files = {}
        for file in io.popen("find " .. session_path .. "/ -type f | grep '" .. time .. "'"):lines() do
            table.insert(same_time_files, file)
        end

        -- 解析已存在的 ID
        local exist_id = {}
        for _, file_id in ipairs(same_time_files) do
            file_id = string.match(file_id, "%*(%d+)%.")
            table.insert(exist_id, file_id)
        end

        -- 在最大的 ID 之上 +1 作为新的 ID
        if #exist_id ~= 0 then
            id = math.max(table.unpack(exist_id)) + 1
        end

        -- 拼接为文件名并替换参数 (格式: [%Y-%m-%d_%H:%M]_*[ID], e.g. 2024-11-21_02:45_*3)
        opts.args = time .. "_*" .. id
    end

    -- 记录当前标签页
    local current_tab = vim.fn.tabpagenr()

    -- 关闭所有 Neotree 窗口
    vim.cmd("tabdo Neotree close")
    -- 关闭所有 Neotree 窗口
    vim.cmd("tabdo MinimapClose")

    -- 回到原来的标签页
    vim.cmd("tabnext " .. current_tab)

    -- 保存路径
    save_path = session_path .. "/" .. opts.args .. ".vim"

    -- 保存会话文件
    vim.cmd("mksession! " .. save_path)

    if flag.no_name == true then
        vim.notify(save_path .. "\n\n(使用自动设定的保存文件名)", "info", { title = module_format_name_endspace .. "会话保存成功" })
    else
        vim.notify(save_path, "info", { title = module_format_name_endspace .. "会话保存成功" })
    end

    -- 执行清理
    clean()

end, {
    nargs = "?"
})

-- 清理运行残留的辅助函数
function clean()
    flag.no_name = nil
end

