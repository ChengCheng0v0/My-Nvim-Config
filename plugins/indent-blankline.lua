local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = _G.palette.red })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = _G.palette.yellow })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = _G.palette.blue })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = _G.palette.peach })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = _G.palette.green })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = _G.palette.mauve })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = _G.palette.sapphire })
end)

require("ibl").setup {
    indent = {
        highlight = highlight,
        char = "▏"
    }
}

