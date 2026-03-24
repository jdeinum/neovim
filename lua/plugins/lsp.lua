local lspconfig_config = require("config.lspconfig")
local trouble_config = require("config.trouble")

return {
	-- LSP config provides the backbone for installing different language
	-- servers that can be used within neovim
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		config = lspconfig_config.config,
		opts = lspconfig_config.opts,
	},

	-- Mason makes installing necessary language servers, linters, etc super
	-- easy
	-- Make sure you run :checkhealth to ensure all of the necessary tooling is
	-- installed
	{
		"williamboman/mason.nvim",
		opts = {},
		keys = {
			{ "<leader>lm", "<cmd>Mason<cr>", mode = "n", desc = "Open Mason" },
		},
	},

	-- Provides some useful features like LSPInstall
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = false,
			automatic_enable = false,
		},
	},

	-- LSP diagnostics, code actions, etc.
	{
		"folke/trouble.nvim",
		opts = { focus = true },
		cmd = "Trouble",
		keys = trouble_config.keys,
	},

	-- Neotest for running tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rouge8/neotest-rust",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust"),
				},
			})
		end,
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
			{ "<leader>tO", function() require("neotest").output.close() end, desc = "Close test output" },
			{ "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output panel" },
		},
	},

	-- Linting support
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "pylint" },
				javascript = { "eslint" },
				typescript = { "eslint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
