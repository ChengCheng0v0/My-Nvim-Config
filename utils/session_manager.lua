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
    no_name = false,                     -- 未指定保存文件名

    management_session_menu = {
        win = nil,
        buf = nil,
    }
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

-- 管理会话
M.management_session_menu = {}
M.management_session = function()
    -- 获取屏幕尺寸
    local screen_width = vim.o.columns
    local screen_height = vim.o.lines

    -- 定义浮动窗口尺寸
    local width = 65
    local height = 20

    -- 计算窗口居中位置
    local row = math.floor((screen_height - height) / 2)
    local col = math.floor((screen_width - width) / 2)

    -- 创建一个新的缓冲区
    local buf = vim.api.nvim_create_buf(false, true)

    -- 定义浮动窗口的显示选项
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded", -- 添加边框样式，可选 rounded、single、double
    }

    -- 将会话列表填充为选单选项
    local menu_items = {}
    local menu_item_id = 1
    for session_name in io.popen("find " .. session_path .. "/ -type f -printf '%f\n' | grep '.vim'"):lines() do
        table.insert(menu_items, "(" .. menu_item_id .. ") " .. string.gsub(session_name, "%.vim$", ""))
        menu_item_id = menu_item_id + 1
    end

    -- 定义选项操作
    M.management_session_menu.actions = {}
    local menu_action_id = 1
    for session_name in io.popen("find " .. session_path .. "/ -type f -printf '%f\n' | grep '.vim'"):lines() do
        -- 加载会话
        M.management_session_menu.actions[menu_action_id .. "l"] = function()
            M.load_session(string.gsub(session_name, "%.vim$", ""), false)
        end

        -- 深度加载会话
        M.management_session_menu.actions[menu_action_id .. "L"] = function()
            M.load_session(string.gsub(session_name, "%.vim$", ""), true)
        end

        menu_action_id = menu_action_id + 1
    end

    -- 渲染窗口内容
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, menu_items)
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, vim.fn["repeat"]({ "" }, height - (#menu_items + 3)))
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { string.rep("─", width) })
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "(?)l : 加载会话 | (?)L : 深度加载会话" })
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "q : 退出菜单" })

    -- 打开浮动窗口
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- 禁用符号列
    vim.wo.signcolumn = "no"

    -- 高亮选项序号
    for i, line in ipairs(menu_items) do
        vim.api.nvim_buf_add_highlight(buf, -1, "Number", i - 1, 0, 3) -- 高亮前3个字符
    end

    -- 匹配并高亮关键字
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false) -- 获取整个缓冲区的内容
    for row, line in ipairs(lines) do
        if line:match("─") then
            for start, finish in line:gmatch("()─()") do
                vim.api.nvim_buf_add_highlight(buf, -1, "WinSeparator", row - 1, start - 1, finish)
            end
        end
        if line:match("%(%?%)") then
            for start, finish in line:gmatch("()%(%?%)()") do
                vim.api.nvim_buf_add_highlight(buf, -1, "Number", row - 1, start - 1, finish)
            end
        end
        if line:match(". :") then
            for start, finish in line:gmatch("().() :") do
                vim.api.nvim_buf_add_highlight(buf, -1, "Keyword", row - 1, start - 1, finish)
            end
        end
    end

    -- 绑定会话操作快捷键
    for i, _ in ipairs(menu_items) do
        local key = tostring(i) -- 将索引转换为字符

        -- 加载会话
        vim.api.nvim_buf_set_keymap(
            buf, "n", key .. "l",
            string.format(":lua require'utils.session_manager'.management_session_menu.handle_selection('%dl')<CR>", i),
            { noremap = true, silent = true }
        )

        -- 深度加载会话
        vim.api.nvim_buf_set_keymap(
            buf, "n", key .. "L",
            string.format(":lua require'utils.session_manager'.management_session_menu.handle_selection('%dL')<CR>", i),
            { noremap = true, silent = true }
        )

        -- 退出菜单
        vim.api.nvim_buf_set_keymap(
            buf, "n", "q",
            string.format(":q | :lua vim.notify(' …〒_〒… ｏ′-一┳═┻︻▄', 'info', { title = '" .. module_format_name_endspace .. "菜单已关闭' })<CR>"),
            { noremap = true, silent = true }
        )
    end

    -- 禁用其它操作
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    -- 存储窗口 ID 和缓冲区 ID
    M.flag.management_session_menu.win = win
    M.flag.management_session_menu.buf = buf

    M.management_session_menu.handle_selection = function(choice)
        -- 关闭浮动窗口
        local win = M.flag.management_session_menu.win
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end

        -- 调用对应的操作
        local actions = M.management_session_menu.actions
        if actions and actions[choice] then
            actions[choice]()
        else
            vim.notify("无效选项。", "error", { title = module_format_name_endspace .. "操作执行失败" })
        end
    end
end

-- 获取当前会话名
M.get_current_session_name = function()
    return M.flag.current_session_name
end

-- 导出模块
return M

