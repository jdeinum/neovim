local vim = vim

return {

	-- Neo-tree (disabled - using snacks.explorer instead)
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	keys = neotree_config.keys,
	-- 	opts = neotree_config.opts,
	-- 	deactivate = function()
	-- 		vim.cmd([[Neotree close]])
	-- 	end,
	-- },

	-- Flash is the enhanced movement mechanism that will get you to any point
	-- in your buffer within 2-3 keystrokes.
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
	},
	-- Harpoon for file navigation
	-- Typically you only have a handful of main files that you want to cycle
	-- through while also opening some different files through find definition
	-- or whatever. Harpoon is my current solution for that.
	-- See https://www.youtube.com/watch?v=Qnos8aApa9g for why it might be
	-- useful
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
		end,
		keys = {
			{ "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
			{ "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
			{ "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
			{ "<C-t>", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
			{ "<C-n>", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
			{ "<C-s>", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
			{ "[h", function() require("harpoon"):list():prev() end, desc = "Harpoon prev" },
			{ "]h", function() require("harpoon"):list():next() end, desc = "Harpoon next" },
		},
	},

	-- Marks improves the existing neovim marks functionality
	{
		"chentoast/marks.nvim",
		opts = {},
	},

	-- Oil.nvim provides a buffer-based file explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
			},
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
	},
}
