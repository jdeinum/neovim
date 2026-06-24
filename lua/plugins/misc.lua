return {

-- Markview: In-buffer markdown preview with LaTeX/Typst support
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Don't lazy load - plugin handles its own lazy loading
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preview = {
				enable = false, -- Preview OFF by default - toggle with <leader>um
				modes = { "n", "no", "c" },
				hybrid_modes = { "n" }, -- Show raw text on cursor line when preview is enabled
			},

			-- Headings
			headings = {
				enable = true,
				shift_width = 1,
			},

			-- Code blocks
			code_blocks = {
				enable = true,
				style = "language", -- Show language label
				pad_amount = 2,
				min_width = 60,
			},

			-- Checkboxes
			checkboxes = {
				enable = true,
				checked = { text = "󰄬", hl = "MarkviewCheckboxChecked" },
				unchecked = { text = "󰄰", hl = "MarkviewCheckboxUnchecked" },
			},

			-- List items
			list_items = {
				enable = true,
				shift_width = 2,
			},

			-- Tables
			tables = {
				enable = true,
			},

			-- Links
			links = {
				enable = true,
			},

			-- Horizontal rules
			horizontal_rules = {
				enable = true,
			},
		},
		keys = {
			-- Toggle markview on/off (follows <leader>u toggle pattern)
			{
				"<leader>um",
				"<cmd>Markview toggle<cr>",
				desc = "Toggle markdown preview",
			},
			-- Split view: side-by-side editing
			{
				"<leader>uM",
				"<cmd>Markview splitToggle<cr>",
				desc = "Toggle markdown split view",
			},
		},
	},
}
