return {
	-- Live browser preview for Typst: opens a synced view (scroll + click-to-jump)
	-- that live-reloads on save. LSP (tinymist) and formatting (typstyle) are
	-- wired separately in config/lspconfig.lua and config/conform.lua.
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {},
		keys = {
			{ "<leader>ut", "<cmd>TypstPreview<cr>", ft = "typst", desc = "Toggle Typst preview" },
			{ "<leader>uT", "<cmd>TypstPreviewStop<cr>", ft = "typst", desc = "Stop Typst preview" },
		},
	},
}
