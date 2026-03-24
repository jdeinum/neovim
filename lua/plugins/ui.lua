local vim = vim

-- configs
local noice_config = require("config.noice")

return {
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight-storm]])
		end,
	},

	-- Cyberdream colorscheme
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			italic_comments = true,
		},
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		},
	},

	-- Notifications and UI improvements
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = noice_config.opts,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- dressing.nvim: removed — snacks.input and snacks.picker handle vim.ui.input/select

	-- Smooth scrolling (disabled - using snacks.scroll instead)
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	config = function()
	-- 		require("neoscroll").setup({
	-- 			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	-- 		})
	-- 	end,
	-- },
}
