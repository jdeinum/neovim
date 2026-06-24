local M = {}

M.config = function()
	require("nvim-treesitter").setup({})
	require("nvim-treesitter").install({ "rust", "lua", "c", "python", "go", "nix", "json", "toml", "yaml" })

	-- Enable treesitter highlighting and indentation for all filetypes with a parser
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local ok = pcall(vim.treesitter.start, args.buf)
			if ok then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})

	-- Incremental selection: v to expand to parent node, V to shrink to child node
	-- Uses Neovim's built-in treesitter incremental selection (an/in)
	vim.keymap.set("x", "v", "an", { remap = true, desc = "Expand selection to parent node" })
	vim.keymap.set("x", "V", "in", { remap = true, desc = "Shrink selection to child node" })
end

return M
