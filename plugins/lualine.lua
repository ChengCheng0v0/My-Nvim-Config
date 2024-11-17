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
		ignore_focus = {},
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
			"diagnostics",
		},
		lualine_x = {
			function()
				return " [" .. vim.fn.getcwd() .. "]"
			end,
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
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

