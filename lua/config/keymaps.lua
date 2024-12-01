-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

local map = vim.api.nvim_set_keymap

--------------------

-- 普通模式下按 ( 移动光标至(软)行首
map("n", "(", "^", { noremap = true, silent = true })
-- 普通模式下按 ) 移动光标至行尾
map("n", ")", "$", { noremap = true, silent = true })

-- 普通模式下按 b 不会发生任何事情 :)
map("n", "b", "", { noremap = true, silent = true })
-- 普通模式下按 bb 新建缓冲区标签
map("n", "bb", ":enew<CR>", { noremap = true, silent = true, desc = "New Buffer" })
-- 普通模式下按 bd 关闭缓冲区
map("n", "bd", ":bdelete<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
-- 普通模式下按 b, 切换至上一个缓冲区标签
map("n", "b,", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })
-- 普通模式下按 b. 切换至下一个缓冲区标签
map("n", "b.", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
