--[[

+-------------------------------------------------+
| G | H | I                             R | S | T |
+-------------------------------------------------+
+-------------------------------------------------+
| D | E | F                             U | V | W |
+-------------------------------------------------+


+-------------------------------------------------+
| A | B | C                             X | Y | Z |
+-------------------------------------------------+

---------------------------------------------------

- G: 可用标签页
- H: null
- I: null
- -
- R: null
- S: 用户名和主机名
- T: 当前根目录

- D: null
- E: 录制信息
- F: null
- -
- U: null
- V: Git Blame
- W: null

- A: 当前模式
- B: 文件名
- C: "(＠_＠;)", Git 分支, Git 差异
- -
- X: LSP 检查, 文档字数, 文件编码, 文件大小, 文件语言
- Y: 光标所在进度
- Z: 光标所在位置

--]]

local git_blame = require("gitblame")

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = {
            left = "|",
            right = "|",
        },
        section_separators = {
            left = "",
            right = "",
        },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = { "neo-tree", "minimap" },
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                separator = {
                    left = "",
                },
            },
        },
        lualine_b = {
            {
                "filename",
                separator = {
                    left = "",
                    right = "",
                },
            },
        },
        lualine_c = {
            {
                function()
                    return "(＠_＠;)"
                end,
                padding = {
                    left = 2,
                    right = 1,
                },
            },
            "branch",
            "diff",
        },
        lualine_x = {
            "diagnostics",
            {
                function()
                    local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
                    local word_count = #content:gsub("%s", "")
                    return word_count
                end,

                cond = function()
                    local file_type = vim.opt_local.filetype:get()
                    local count = {
                        latex = true,
                        tex = true,
                        text = true,
                        markdown = true,
                        vimwiki = true,
                    }
                    return count[file_type] ~= nil
                end,
            },
            "encoding",
            "filesize",
            {
                "filetype",
                padding = {
                    left = 1,
                    right = 2,
                },
            },
        },
        lualine_y = {
            {
                "progress",
                separator = {
                    left = "",
                    right = "",
                },
            },
        },
        lualine_z = {
            {
                "location",
                separator = {
                    right = "",
                },
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            {
                "tabs",
                mode = 1,
                path = 0,
                max_length = vim.o.columns * 0.7,
                tabs_color = {
                    active = {
                        fg = _G.palette.mantle,
                        bg = _G.palette.pink,
                        gui = "bold",
                    },
                    inactive = {
                        fg = _G.palette.pink,
                        bg = _G.palette.surface0,
                    },
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                function()
                    return io.popen('echo "$USER@$(hostname)"'):read("*a"):gsub("%s+$", "")
                end,
                color = {
                    fg = _G.palette.pink,
                    bg = _G.palette.surface0,
                },
            },
        },
        lualine_z = {
            {
                function()
                    return vim.fn.getcwd()
                end,
                color = {
                    fg = _G.palette.mantle,
                    bg = _G.palette.pink,
                },
            },
        },
    },
    winbar = {
        lualine_a = {},
        lualine_b = {
            {
                function()
                    local rec_register = vim.fn.reg_recording()
                    if rec_register ~= "" then
                        return "Recording @" .. rec_register
                    else
                        return ""
                    end
                end,
                icon = {
                    "",
                    align = "left",
                },
                color = {
                    fg = "#ffffff",
                    bg = "#cb1b45",
                    gui = "bold",
                },
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                function()
                    return string.gsub(git_blame.get_current_blame_text(), "^%s+", "")
                end,
                icon = {
                    "",
                    align = "left",
                },
                color = {
                    fg = _G.palette.mauve,
                    bg = _G.palette.surface0,
                },

                cond = git_blame.is_blame_text_available,
            },
        },
        lualine_z = {},
    },
    inactive_winbar = {},
    extensions = {},
})

