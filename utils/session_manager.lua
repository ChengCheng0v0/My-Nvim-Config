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
    -- 关闭所有 Minimap 窗口
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

-- 加载会话
M.load_session = function(session_name, deep_load)
    -- 检查参数是否合法
    if session_name == nil or session_name == "" then
        vim.notify("未传入 session_name 参数或传入的值为空。", "error", { title = module_format_name_endspace .. "会话加载失败" })
        return
    elseif vim.loop.fs_stat(vim.fn.expand(session_path .. "/" .. session_name .. ".vim")) == nil then
        vim.notify("指定的会话文件不存在。", "error", { title = module_format_name_endspace .. "会话加载失败" })
        return
    end

    -- 加载路径
    local load_path = session_path .. "/" .. session_name .. ".vim"

    -- 检查是否需要深度加载
    if deep_load == true then
        vim.notify("即将执行深度加载，再见...\n\n" .. load_path, "warn", { title = module_format_name_endspace .. "准备深度加载" })

        vim.defer_fn(function()
            vim.cmd("bufdo bdelete") -- 清空所有缓冲区
            vim.cmd("tabdo only") -- 关闭所有分屏
            vim.cmd("source $MYVIMRC") -- 重新加载配置文件

            -- 加载会话文件
            vim.cmd("source " .. load_path)

            vim.notify(load_path, "info", { title = module_format_name_endspace .. "会话深度加载成功" })

            -- 更新当前会话名
            M.flag.current_session_name = session_name
        end, 3000)
    else
        -- 加载会话文件
        vim.cmd("source " .. load_path)

        vim.notify(load_path, "info", { title = module_format_name_endspace .. "会话加载成功" })

        -- 更新当前会话名
        M.flag.current_session_name = session_name
    end
end

-- 获取当前会话名
M.get_current_session_name = function()
    return M.flag.current_session_name
end

-- 导出模块
return M

