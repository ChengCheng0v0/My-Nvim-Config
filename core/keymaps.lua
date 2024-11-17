-- 引入插件配置 (选项式)
local neo_tree_config = require("plugins.neotree").config

--------------------

-- 普通模式下按 Space 键进入底线命令模式
vim.api.nvim_set_keymap("n", "<Space>", ":", {noremap = true })

-- 普通模式下按 q/w 不会发生任何事情 :)
vim.api.nvim_set_keymap("n", "q", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "w", "", { noremap = true, silent = true })

-- 普通模式下按 qq 或 Q 退出
vim.api.nvim_set_keymap("n", "qq", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Q", ":q<CR>", { noremap = true, silent = true })

-- 普通模式下按 ? 清除搜索
vim.keymap.set("n", "?", ":nohlsearch<CR>", { noremap = true, silent = true })

-- 普通模式下按 dd 将行写入黑洞寄存器
vim.keymap.set("n", "dd", "\"_dd", { noremap = true, silent = true })

-- 普通模式下按 h 向后进入插入模式
vim.api.nvim_set_keymap("n", "h", "a", { noremap = true, silent = true })
-- 普通模式下按 Esc 向前进入插入模式
vim.api.nvim_set_keymap("n", "<Esc>", "i", { noremap = true, silent = true })
-- 插入模式下按 Esc 返回普通模式
vim.api.nvim_set_keymap("i", "<Esc>", "<Esc>", { noremap = true, silent = true })

-- 普通模式下按 m 进入可视模式
vim.api.nvim_set_keymap("n", "m", "v", { noremap = true, silent = true })
-- 普通模式下按 M 进入可视行模式
vim.api.nvim_set_keymap("n", "M", "V", { noremap = true, silent = true })
-- 可视模式下按 m 返回普通模式
vim.api.nvim_set_keymap("v", "m", "<Esc>", { noremap = true, silent = true })

-- 终端模式下按 Esc 返回普通模式
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- 普通模式下按 i/k/j/l 移动光标
vim.api.nvim_set_keymap("n", "i", "<Up>", { noremap = true, silent = true })    -- 上
vim.api.nvim_set_keymap("n", "k", "<Down>", { noremap = true, silent = true })  -- 下
vim.api.nvim_set_keymap("n", "j", "<Left>", { noremap = true, silent = true })  -- 左
vim.api.nvim_set_keymap("n", "l", "<Right>", { noremap = true, silent = true }) -- 右

-- 可视模式下按 i/k/j/l 移动光标
vim.api.nvim_set_keymap("v", "i", "<Up>", { noremap = true, silent = true })    -- 上
vim.api.nvim_set_keymap("v", "k", "<Down>", { noremap = true, silent = true })  -- 下
vim.api.nvim_set_keymap("v", "j", "<Left>", { noremap = true, silent = true })  -- 左
vim.api.nvim_set_keymap("v", "l", "<Right>", { noremap = true, silent = true }) -- 右

-- 插入模式下按 Alt + i/k/j/l 移动光标
vim.api.nvim_set_keymap("i", "<A-i>", "<Up>", { noremap = true, silent = true })    -- 上
vim.api.nvim_set_keymap("i", "<A-k>", "<Down>", { noremap = true, silent = true })  -- 下
vim.api.nvim_set_keymap("i", "<A-j>", "<Left>", { noremap = true, silent = true })  -- 左
vim.api.nvim_set_keymap("i", "<A-l>", "<Right>", { noremap = true, silent = true }) -- 右

-- 普通模式下按 Alt + j 移动到上一个单词头部
vim.api.nvim_set_keymap("n", "<A-j>", "b", { noremap = true, silent = true })
-- 普通模式下按 Alt + l 移动到下一个单词尾部
vim.api.nvim_set_keymap("n", "<A-l>", "e", { noremap = true, silent = true })

-- 普通模式下按 Alt + i 向上滚动视图
vim.api.nvim_set_keymap("n", "<A-i>", "3<C-y>", { noremap = true, silent = true })
-- 普通模式下按 Alt + k 向下滚动视图
vim.api.nvim_set_keymap("n", "<A-k>", "3<C-e>", { noremap = true, silent = true })

-- 普通模式下按 Ctrl + i 向上滚动半页
vim.api.nvim_set_keymap("n", "<C-i>", "<C-u>", { noremap = true, silent = true })
-- 普通模式下按 Ctrl + k 向下滚动半页
vim.api.nvim_set_keymap("n", "<C-k>", "<C-d>", { noremap = true, silent = true })

-- 普通模式下按 wi/wk/wj/wl 切换窗口
vim.api.nvim_set_keymap("n", "wi", "<C-w><Up>", { noremap = true, silent = true })    -- 上
vim.api.nvim_set_keymap("n", "wk", "<C-w><Down>", { noremap = true, silent = true })  -- 下
vim.api.nvim_set_keymap("n", "wj", "<C-w><Left>", { noremap = true, silent = true })  -- 左
vim.api.nvim_set_keymap("n", "wl", "<C-w><Right>", { noremap = true, silent = true }) -- 右

-- 普通模式下按 ww 回到上一个窗口
vim.api.nvim_set_keymap("n", "ww", "<C-w>p", { noremap = true, silent = true })

-- 普通模式下按 t 新建标签页
vim.api.nvim_set_keymap("n", "t", ":tabnew<CR>", { noremap = true, silent = true })
-- 普通模式下按 T 关闭标签页
vim.api.nvim_set_keymap("n", "T", ":tabclose<CR>", { noremap = true, silent = true })

-- 普通模式下按 ,/. 切换标签页
vim.api.nvim_set_keymap("n", ",", ":tabprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ".", ":tabnext<CR>", { noremap = true, silent = true })

-- 普通模式下按 z 撤销
vim.api.nvim_set_keymap("n", "z", "u", { noremap = true, silent = true })
-- 普通模式下按 Z 重做
vim.api.nvim_set_keymap("n", "Z", "<C-r>", { noremap = true, silent = true })

-- 普通模式下按 x 剪切行
vim.api.nvim_set_keymap("n", "x", "dd", { noremap = true, silent = true })
-- 普通模式下按 c 复制行
vim.api.nvim_set_keymap("n", "c", "Y", { noremap = true, silent = true })
-- 普通模式下按 v 向前粘贴
vim.api.nvim_set_keymap("n", "v", "P", { noremap = true, silent = true })
-- 普通模式下按 V 向后粘贴
vim.api.nvim_set_keymap("n", "V", "p", { noremap = true, silent = true })

-- 插入模式下按 Ctrl + v 粘贴
vim.api.nvim_set_keymap("i", "<C-v>", "<Esc>pa", { noremap = true, silent = true })
-- 插入模式下按 Alt + d 退格
vim.api.nvim_set_keymap("i", "<A-d>", "<Backspace>", { noremap = true, silent = true })

-- 可视模式下按 x 剪切
vim.api.nvim_set_keymap("v", "x", "d", { noremap = true, silent = true })
-- 可视模式下按 c 复制
vim.api.nvim_set_keymap("v", "c", "y", { noremap = true, silent = true })
-- 可视模式下按 d 删除
vim.api.nvim_set_keymap("v", "d", "\"_d", { noremap = true, silent = true })

-- 普通模式下按 p 开始录制宏
vim.api.nvim_set_keymap("n", "p", "q", { noremap = true, silent = true })

-- 普通模式下按 f 打开/关闭 Neotree
vim.api.nvim_set_keymap("n", "f", ":Neotree toggle<CR>", { noremap = true, silent = true })
-- 普通模式下按 F 设置根目录并聚焦 Neotree
vim.api.nvim_set_keymap("n", "F", ":Neotree focus reveal ", { noremap = true })

-- Neotree 窗口内的键位绑定
neo_tree_config.window.mappings = {
    ["."] = "",                 -- 解绑 .
    ["w"] = "",                 -- 解绑 w

    ["i"] = "move_up",          -- 上移
    ["k"] = "move_down",        -- 下移
    ["j"] = "prev_source",      -- 切换到上一个目录源
    ["l"] = "next_source",      -- 切换到下一个目录源
 
    ["z"] = "expand_all_nodes", -- 展开所有节点
    ["Z"] = "close_all_nodes",  -- 关闭所有节点
}

-- 普通模式下按 \ 显示/隐藏 Minimap
vim.api.nvim_set_keymap("n", "\\", ":MinimapToggle<CR>", { noremap = true, silent = true })

-- 普通模式下按 ` 执行 ALE 修复
vim.api.nvim_set_keymap("n", "`", ":ALEFix<CR>", { noremap = true })

-- 普通模式下按 ' 打开/关闭 ToggleTerm 终端 (水平)
--vim.api.nvim_set_keymap("n", "'", ":ToggleTerm direction=horizontal size=15<CR>", { noremap = true, silent = true })
-- 普通模式下按 " 打开/关闭 ToggleTerm 终端 (垂直)
--vim.api.nvim_set_keymap("n", "\"", ":ToggleTerm direction=vertical size=65<CR>", { noremap = true, silent = true })

--------------------

-- 应用插件配置
require("neo-tree").setup(neo_tree_config)

