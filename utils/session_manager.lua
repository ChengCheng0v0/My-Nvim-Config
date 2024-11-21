-- 定义模块
local M = {}

-- 模块名
local module_name = "Session Manager"
local module_format_name = "[Session Manager]"
local module_format_name_endspace = "[Session Manager] "
-- 会话保存路径
local session_path = "~/.local/share/nvim/session"

-- Flags
M.flag = {
    current_session_name = "No Session", -- 当前会话名
    no_name = false                      -- 未指定保存文件名
}

-- 保存会话
M.save_session = function(save_name)
    -- 如果未指定保存文件名则使用预设文件名
    if save_name == nil or save_name == "" then
        M.flag.no_name = true -- 更新 Flag

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
        save_name = time .. "_*" .. id
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
    save_path = session_path .. "/" .. save_name .. ".vim"

    -- 保存会话文件
    vim.cmd("mksession! " .. save_path)

    if M.flag.no_name == true then
        vim.notify(save_path .. "\n\n(使用自动设定的保存文件名)", "info", { title = module_format_name_endspace .. "会话保存成功" })
    else
        vim.notify(save_path, "info", { title = module_format_name_endspace .. "会话保存成功" })
    end

    -- 更新当前会话名
    M.flag.current_session_name = save_name
    --vim.notify(M.flag.current_session_name, "warn", { title = module_format_name_endspace .. "Debug" })
    -- 重置 Flag
    M.flag.no_name = false
end

-- 获取当前会话名
M.get_current_session_name = function()
    return M.flag.current_session_name
end

-- 导出模块
return M

