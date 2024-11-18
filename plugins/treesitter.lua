vim.defer_fn(function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "lua", "html", "css", "javascript", "json", "java", "rust", "python", "sql" }, -- 自动安装语法高亮
        highlight = {
            enable = true, -- 启用语法高亮
            --additional_vim_regex_highlighting = false, -- 禁用传统高亮
        },
    })
end, 20) -- 延迟执行以确保插件加载完成

