local vim = vim

local treesitter_config = require("config.treesitter")
local conform_config = require("config.conform")

return {

	-- Which key provides useful type hints when doing different actions within
	-- neovim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>g", group = "git" },
				{ "<leader>gv", group = "diffview" },
				{ "<leader>l", group = "tools" },
				{ "<leader>s", group = "search/symbols" },
				{ "<leader>t", group = "test" },
				{ "<leader>u", group = "toggle" },
				{ "<leader>x", group = "trouble" },
				{ "<localleader>f", group = "find" },
				{ "<localleader>g", group = "git" },
				{ "<localleader>s", group = "search" },
			})
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- Snacks contain a bunch of quality of life improvements fopr neovim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						auto_close = true,
						layout = {
							layout = {
								width = 60,
								min_width = 50,
							},
						},
					},
				},
			},
			toggle = { enabled = true },
			zen = { enabled = true },
			scroll = { enabled = false },
			scope = { enabled = false }, -- Disable to prevent flicker when editing
			rename = { enabled = true },
			keymap = { enabled = true },
			profiler = { enabled = true },
			indent = {
				enabled = true,
				animate = {
					enabled = false, -- Disable fade-in animations
				},
				scope = {
					enabled = false, -- No color change for current scope
				},
				only_scope = false, -- Show all indent lines, not just scope
			},
			input = { enabled = true },
			dim = { enabled = false }, -- Disabled by default, toggle with <leader>ud
			explorer = {
				enabled = true,
			},
		},
		keys = {
			-- File & Navigation
			{
				"<localleader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<localleader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find git files",
			},
			{
				"<localleader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<localleader>x",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent files",
			},
			{
				"<localleader>fs",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart find",
			},

			-- Search
			{
				"<localleader>ss",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<localleader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Grep word",
			},
			{
				"<localleader>sb",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer lines",
			},

			-- Git
			{
				"<localleader>gc",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git branches",
			},
			{
				"<localleader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git log",
			},
			{
				"<localleader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git status",
			},

			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "References",
			},
			{
				"gi",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Buffer Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},

			-- Utility
			{
				"<localleader>:",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<localleader>h",
				function()
					Snacks.picker.help()
				end,
				desc = "Help",
			},
			{
				"<localleader>d",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},

			-- Quickfix
			{
				"<localleader>fq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},

			-- Buffer management
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bo",
				function()
					Snacks.bufdelete.other()
				end,
				desc = "Delete Other Buffers",
			},

			-- Toggles (all under <leader>u)
			{
				"<leader>ud",
				function()
					Snacks.toggle.dim():toggle()
				end,
				desc = "Toggle dim",
			},
			{
				"<leader>uI",
				function()
					Snacks.toggle.indent():toggle()
				end,
				desc = "Toggle indent scope",
			},
			{
				"<leader>uz",
				function()
					Snacks.zen()
				end,
				desc = "Toggle zen mode",
			},
			{
				"<leader>uZ",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle zoom",
			},

			-- Rename
			{
				"<leader>r",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "LSP Rename",
			},
			{
				"<leader>R",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename file",
			},

			-- Explorer
			{
				"<localleader>a",
				function()
					Snacks.explorer()
				end,
				desc = "Toggle Explorer",
			},

			-- Profiler
			{
				"<leader>lp",
				function()
					Snacks.profiler.show()
				end,
				desc = "Show profiler",
			},
		},
	},

	-- Indent guides (disabled - using snacks.indent instead)
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {},
	-- },

	-- Treesitter provides all of our syntax highlighting for different
	-- languages
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = treesitter_config.config,
	},

	-- Telescope (disabled - using Snacks picker instead)
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	tag = "0.1.8",
	-- 	cmd = "Telescope",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	opts = telescope_config.opts,
	-- 	keys = telescope_config.keys,
	-- },

	-- nvim surround is a super helpful plugin that makes it easy to surround
	-- existing text with symbols like " ' { [ etc
	-- Really helpful when porting between configuration file types
	{

		"kylechui/nvim-surround",

		version = "*",

		event = "VeryLazy",

		opts = {},
	},

	-- Comment: gc/gcc are built-in since Neovim 0.10+

	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			mappings = {
				["'"] = false,
			},
		},
	},

	-- Highlight and search TODO/FIXME/HACK/NOTE comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
			{ "<localleader>ft", function() Snacks.picker.todo_comments() end, desc = "TODOs (Picker)" },
			{ "<localleader>fT", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
		},
	},

	-- Code formatting

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = conform_config.keys,
		config = conform_config.config,
	},

	-- Motion enhancements

	-- Icon picker
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({ disable_legacy_commands = true })
			vim.keymap.set(
				"n",
				"<Leader>li",
				"<cmd>IconPickerNormal<cr>",
				{ noremap = true, silent = true, desc = "Pick Icon" }
			)
		end,
	},

	-- Highlight yanked text
	{
		"rachartier/tiny-glimmer.nvim",
		event = "TextYankPost",
		opts = {
			modules = {
				yank = { enabled = true },
			},
		},
	},

	-- Search and replace
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and Replace" },
		},
	},

	-- Substitute operator
	{
		"gbprod/substitute.nvim",
		opts = {},
		keys = {
			{ "gs", "<cmd>lua require('substitute').operator()<cr>", desc = "Substitute operator" },
			{ "gss", "<cmd>lua require('substitute').line()<cr>", desc = "Substitute line" },
			{ "gS", "<cmd>lua require('substitute').eol()<cr>", desc = "Substitute to EOL" },
			{ "gs", "<cmd>lua require('substitute').visual()<cr>", mode = "x", desc = "Substitute visual" },
		},
	},

	-- Split/join code blocks
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			use_default_keymaps = false,
		},
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
		},
	},
}
