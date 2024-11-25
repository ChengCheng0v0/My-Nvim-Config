---- Catppuccin 主题

-- 加载主题插件
vim.call("plug#begin")
vim.fn["plug#"] ("catppuccin/nvim")
vim.call("plug#end")

-- 设置 Catppuccin
require("catppuccin").setup({
    flavour = "mocha", -- 可选 "latte", "frappe", "macchiato", "mocha"
    transparent_background = true, -- 启用透明背景
})
-- 全局调色板
_G.palette = require("catppuccin.palettes").get_palette("mocha")

-- 应用主题
vim.cmd.colorscheme("catppuccin")

---- 自定义

-- 彩虹🌈
vim.api.nvim_set_hl(0, "RainbowRed", { fg = _G.palette.red })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = _G.palette.yellow })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = _G.palette.blue })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = _G.palette.peach })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = _G.palette.green })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = _G.palette.mauve })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = _G.palette.sapphire })

-- 分割线
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#89b4fa", bg = "NONE" })

-- Git Gutter
vim.api.nvim_set_hl(0, "GitGutterAdd", { fg = _G.palette.green })
vim.api.nvim_set_hl(0, "GitGutterChange", { fg = _G.palette.yellow })
vim.api.nvim_set_hl(0, "GitGutterDelete", { fg = _G.palette.red })

