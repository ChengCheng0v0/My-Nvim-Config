-- 加载插件
local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
    Plug ("nvim-lua/plenary.nvim")
    Plug ("MunifTanjim/nui.nvim")
    Plug ("rcarriga/nvim-notify")
    Plug ("lambdalisue/suda.vim")
    Plug ("nvim-tree/nvim-web-devicons")
    Plug ("catppuccin/nvim")                    -- 再次声明以确保其作用域
    Plug ("nvim-treesitter/nvim-treesitter")
    Plug ("dense-analysis/ale")
    Plug ("wakatime/vim-wakatime")
    Plug ("norcalli/nvim-colorizer.lua")
    Plug ("nvim-neo-tree/neo-tree.nvim")
    Plug ("f-person/git-blame.nvim")
    Plug ("nvim-lualine/lualine.nvim")
    Plug ("wfxr/minimap.vim")
    Plug ("lukas-reineke/indent-blankline.nvim")
    Plug ("HiPhish/rainbow-delimiters.nvim")
    Plug ("airblade/vim-gitgutter")
    Plug ("ms-jpq/coq_nvim")
    Plug ("ms-jpq/coq.artifacts")
    Plug ("ms-jpq/coq.thirdparty")
    Plug ("chentoast/marks.nvim")
vim.call("plug#end")

-- 加载插件选项
require("plugins.options") -- ./options.lua

-- 加载插件配置
require("plugins.notify")           -- ./notify.lua           -- Notify
require("plugins.lualine")          -- ./lualine.lua          -- Lualine
require("plugins.indent-blankline") -- ./indent-blankline.lua -- Indent Blankline
require("plugins.treesitter")       -- ./treesitter.lua       -- Treesitter

-- 引入插件配置 (选项式)
local neo_tree_config = require("plugins.neotree").config -- ./neotree.lua -- Neotree
local marks_config = require("plugins.marks").config      -- ./marks.lua   -- Marks

-- 初始化插件
require("kitty-scrollback").setup() -- Kitty Scrollback
require("lualine").setup()          -- Lualine
require("colorizer").setup()        -- Colorizer

-- 应用插件配置 (选项式)
require("neo-tree").setup(neo_tree_config)
require("marks").setup(marks_config)

-- 启动无法自动启动的插件
vim.defer_fn(function()
    vim.cmd("COQnow --shut-up") -- COQ
end, 20) -- 延迟执行以确保插件加载完成

