local M = {}

M.config = function()
	require("nvim-treesitter").install({
		"rust", "lua", "c", "python", "go", "nix", "json", "toml", "yaml",
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("custom_treesitter", { clear = true }),
		callback = function()
			pcall(vim.treesitter.start)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
end

return M
