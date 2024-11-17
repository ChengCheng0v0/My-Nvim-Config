---- 通用

-- 启用持久化撤销
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo") -- 设置撤销文件保存的路径

-- 搜索大小写不敏感
vim.opt.ignorecase = true -- 大小写始终不敏感
vim.opt.smartcase = true -- 智能模式 (有大写时敏感，否则不敏感)

---- 界面

-- 启用终端中的 24 位颜色支持
vim.opt.termguicolors = true

-- 显示行号
vim.opt.number = true -- 绝对行号
vim.opt.relativenumber = true -- 相对行号

-- 高亮光标所在行
vim.opt.cursorline = true

-- 自动显示符号列
vim.opt.signcolumn = "auto"

-- 滚动时预留三行空白
vim.o.scrolloff = 3

-- 分割线填充
vim.o.fillchars = "vert:│,horiz:━,horizup:┯,horizdown:┷"

-- 垂直分割线颜色
vim.cmd([[highlight WinSeparator guifg=#181825]])

-- 水平分割线颜色
vim.cmd([[highlight VertSplit guifg=#181825]])

---- 编辑

-- 启用系统剪切板
vim.opt.clipboard = "unnamedplus"

-- 使用4个空格缩进
vim.opt.tabstop = 4 -- Tab 宽度为4个空格
vim.opt.shiftwidth = 4 -- 缩进时使用4个空格
vim.opt.expandtab = true -- 将 Tab 转换为空格

