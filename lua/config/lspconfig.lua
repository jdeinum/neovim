local vim = vim
local M = {}

M.opts = {
	servers = {
		rust_analyzer = {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					imports = {
						group = {
							enable = false,
						},
					},
					completion = {
						postfix = {
							enable = false,
						},
					},
				},
			},
		},
		bashls = {},
		lua_ls = {},
		marksman = {},
		pyright = {},
		ansiblels = {
			filetypes = { "yaml" },
		},
		html = {},
		clangd = {
			filetypes = { "c", "h" },
		},
		jsonls = {},
		dockerls = {},
		yamlls = {},
		taplo = {},
		earthlyls = {},
		wasm_language_tools = {},
	},
}

M.config = function(_, opts)
	-- Set default capabilities for all servers
	vim.lsp.config["*"] = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	}

	-- Configure and enable language servers
	for server, config in pairs(opts.servers) do
		vim.lsp.config[server] = config
		vim.lsp.enable(server)
	end

	-- LSP keymaps (gd, gr, gi now handled by Snacks picker)
	vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous Diagnostic" })
	vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
	vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Previous Error" })
	vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next Error" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic Location List" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Signature Help" })
	vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
	vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
	vim.keymap.set("n", "<leader>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "List Workspace Folder" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
	-- Rename moved to Snacks (<leader>r for LSP, <leader>R for file)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
end

return M
