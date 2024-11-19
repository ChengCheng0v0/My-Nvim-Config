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

-- Git Blame
vim.g.gitblame_display_virtual_text = 0 -- 隐藏虚拟文本
vim.g.gitblame_delay = 0 -- 信息显示的视觉延迟
vim.g.gitblame_date_format = "%r" -- 使用相对时间
vim.g.gitblame_message_when_not_committed = "Oh please, commit this!" -- 自定义未提交时的消息
vim.g.gitblame_max_commit_summary_length = 50 -- 最大 Commit 摘要长度

-- Git Gutter
vim.g.gitgutter_sign_priority = 1 -- 始终显示在第一列

