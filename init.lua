-- 设置 package.path
local current_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
package.path = current_path .. "?.lua;" .. current_path .. "?/init.lua;" .. package.path

-- 加载配置
require("core.options")   -- ./core/options.lua   -- 基本选项
require("utils.init")     -- ./utils/init.lua     -- Utils
require("core.highlight") -- ./core/highlight.lua -- 高亮/主题
require("plugins.init")   -- ./plugins/init.lua   -- 插件
require("core.keymaps")   -- ./core/keymaps.lua   -- 键位绑定
require("commands.init")  -- ./commands/init.lua  -- 用户命令
require("autotasks.init") -- ./autotasks/init.lua -- 自动任务
require("core.workspace") -- ./core/workspace.lua -- 工作区

