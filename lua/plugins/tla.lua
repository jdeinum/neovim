return {
	{
		"susliko/tla.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "tla",
		init = function()
			vim.filetype.add({
				extension = { tla = "tla" },
			})
		end,
		config = function()
			require("tla").setup({
				java_executable = "/usr/bin/java",
				tla2tools = "/usr/share/java/tla2tools.jar",
			})

			-- Set up keybindings for TLA+ files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "tla",
				callback = function()
					local opts = { buffer = true, silent = true }
					-- Translate PlusCal to TLA+
					vim.keymap.set("n", "<localleader>t", "<cmd>TlaTranslate<cr>", opts)
					-- Run model checker
					vim.keymap.set("n", "<localleader>c", "<cmd>TlaCheck<cr>", opts)
					-- Install/update TLA+ tools
					vim.keymap.set("n", "<localleader>i", "<cmd>TlaInstall<cr>", opts)
				end,
			})
		end,
	},


}
