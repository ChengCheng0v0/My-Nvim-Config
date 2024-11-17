-- 每隔 3 秒刷新一次 Neotree
vim.loop.new_timer():start(0, 3000, function()
    vim.schedule(function() 
        require("neo-tree.command").execute({ action = "refresh" })
    end)
end)

