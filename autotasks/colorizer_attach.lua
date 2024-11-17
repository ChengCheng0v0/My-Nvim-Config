-- 每隔 3 秒执行一次 :ColorizerAttachToBuffer
vim.loop.new_timer():start(0, 3000, function()
    vim.schedule(function() 
        vim.cmd("ColorizerAttachToBuffer")
    end)
end)

