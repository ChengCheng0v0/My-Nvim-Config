-- Catppuccin 主题
require("catppuccin").setup({
	flavour = "mocha", -- 可选 "latte", "frappe", "macchiato", "mocha"
})

-- ALE
vim.g.ale_lint_on_save = 1 -- 保存时进行 lint 检查
vim.g.ale_lint_on_text_changed = "always" -- 内容改变时进行 lint 检查
vim.g.ale_fixers = { -- 指定各语言使用的修复工具
	lua = { "stylua" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	css = { "prettier" },
	scss = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
}

-- Minimap
vim.g.minimap_auto_start = 0 -- 默认隐藏

