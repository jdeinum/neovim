-- Keymap helper (silent by default, matching snacks behavior)
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Escape key alternatives
for _, key in ipairs({ "j", "k" }) do
	for _, mode in ipairs({ "n", "i", "v", "s", "x", "c", "o", "l", "t" }) do
		map(mode, "<C-" .. key .. ">", "<Esc>", { desc = "Escape to normal mode" })
	end
end

-- Leader mappings
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader><leader>", "<c-^>", { desc = "Switch to last buffer" })
map("n", "<leader>uh", ":set invlist<cr>", { desc = "Toggle hidden characters" })
map("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>', { desc = "Open new file in current directory" })

-- Center search results
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Previous search result (centered)" })
map("n", "*", "*zz", { desc = "Search word under cursor (centered)" })
map("n", "#", "#zz", { desc = "Search word under cursor backward (centered)" })
map("n", "g*", "g*zz", { desc = "Search partial word under cursor (centered)" })

-- Search with better defaults
map("n", "?", "?\\v", { desc = "Very magic search backward" })
map("n", "/", "/\\v", { desc = "Very magic search forward" })
map("c", "%s/", "%sm/", { desc = "Substitute with magic" })

-- Disable arrow keys in normal and insert mode
for _, key in ipairs({ "up", "down" }) do
	map("n", "<" .. key .. ">", "<nop>", { desc = "Disabled (use j/k)" })
	map("i", "<" .. key .. ">", "<nop>", { desc = "Disabled" })
end

for _, key in ipairs({ "left", "right" }) do
	map("i", "<" .. key .. ">", "<nop>", { desc = "Disabled" })
end

-- Arrow keys for buffer navigation
map("n", "<left>", ":bp<cr>", { desc = "Previous buffer" })
map("n", "<right>", ":bn<cr>", { desc = "Next buffer" })

-- Visual line navigation
map("n", "j", "gj", { desc = "Move down by visual line" })
map("n", "k", "gk", { desc = "Move up by visual line" })

-- Quick variable name modification
map("n", "<leader>m", "ct_", { desc = "Change text until underscore" })

-- F1 is Escape
map("", "<F1>", "<Esc>", { desc = "Escape to normal mode" })
map("i", "<F1>", "<Esc>", { desc = "Escape to normal mode" })

-- Quick search clearing
map("n", "<C-c>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })
map("v", "<C-c>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })

-- Duplicate and comment
map("n", "yc", "yygccp", { desc = "Duplicate line and comment original" })

-- Change word
map("n", "<CR>", "ciw", { desc = "Change inner word" })

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Line navigation
map("n", "L", "$", { desc = "Go to end of line" })
map("n", "H", "^", { desc = "Go to start of line" })

-- Diagnostic float at cursor
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })

-- Inlay hints toggle
map("n", "<leader>ui", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- Paste without losing register in visual mode
map("x", "p", [["_dP]], { desc = "Paste without yanking replaced text" })

-- Stay in visual mode after indent
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Open lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- Open URL under cursor (fix for broken default gx)
local function open_url_under_cursor()
	local line = vim.fn.getline(".")
	local col = vim.fn.col(".")

	-- Pattern for URLs (handles most common cases)
	local url_pattern = "https?://[%w%.%-_~:/?#%[%]@!$&'()*+,;=%%]+"

	-- Find all URLs in the line and check if cursor is on one
	local start_pos = 1
	while true do
		local url_start, url_end, url = line:find("(" .. url_pattern .. ")", start_pos)
		if not url_start then break end

		-- Check if cursor is within this URL
		if col >= url_start and col <= url_end then
			-- Clean trailing punctuation that's likely not part of URL
			url = url:gsub("[%)%]>,.;:]+$", "")
			vim.ui.open(url)
			return
		end
		start_pos = url_end + 1
	end

	-- Fallback: try markdown link syntax [text](url) on current line
	local md_url = line:match("%]%((" .. url_pattern .. ")%)")
	if md_url then
		md_url = md_url:gsub("[%)%]>,.;:]+$", "")
		vim.ui.open(md_url)
		return
	end

	-- Last fallback: just try the WORD under cursor
	local word = vim.fn.expand("<cWORD>")
	local url = word:match("https?://[^%s%]%)>]+")
	if url then
		url = url:gsub("[%)%]>,.;:]+$", "")
		vim.ui.open(url)
	end
end

map("n", "gx", open_url_under_cursor, { desc = "Open URL under cursor" })
