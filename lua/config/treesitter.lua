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

	-- Incremental selection: v to expand to parent node, V to shrink to child node
	-- Uses Neovim's built-in treesitter incremental selection (an/in)
	vim.keymap.set("x", "v", "an", { remap = true, desc = "Expand selection to parent node" })
	vim.keymap.set("x", "V", "in", { remap = true, desc = "Shrink selection to child node" })
end

return M
