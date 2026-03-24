return {

	-- Diffview for viewing git diffs and file history
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
			{ "<leader>gvf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
		},
	},

	-- git signs adds nice symbols to the column line to show whats dirty and
	-- what isn't
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous hunk" })

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>gU", gs.reset_buffer_index, { desc = "Unstage buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>gq", gs.setqflist, { desc = "Hunks to quickfix" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line" })
				map("n", "<leader>ub", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
				map("n", "<leader>uB", "<cmd>Gitsigns blame<cr>", { desc = "Toggle buffer blame" })
				map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
				map("n", "<leader>ge", function()
					gs.diffthis("~")
				end, { desc = "Diff this ~" })
				map("n", "<leader>uD", gs.toggle_deleted, { desc = "Toggle deleted" })
				map("n", "<leader>uW", gs.toggle_word_diff, { desc = "Toggle word diff" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		},
	},
}
