local NEW_CLASS = "+ New class..."

local function class_label_from_slug(slug)
	return (slug:gsub("_", " "))
end

local function open_class_note(semester, class)
	local slug = class:upper():gsub("[^%w]+", "_"):gsub("^_+", ""):gsub("_+$", "")
	local dir = "School/" .. semester .. "/" .. slug

	vim.fn.mkdir(vim.env.ZK_NOTEBOOK_DIR .. "/" .. dir, "p")
	require("zk").new({ dir = dir, extra = { class = class } })
end

local function prompt_new_class(semester)
	vim.ui.input({ prompt = "Class (e.g. CMPUT 600): " }, function(class)
		if class and class ~= "" then
			open_class_note(semester, class)
		end
	end)
end

local function new_class_note()
	local semester = vim.env.ZK_SEMESTER
	if not semester then
		vim.notify("ZK_SEMESTER is not set (see ~/.config/fish/config.fish)", vim.log.levels.ERROR)
		return
	end

	local semester_dir = vim.env.ZK_NOTEBOOK_DIR .. "/School/" .. semester
	local slugs = {}
	for _, path in ipairs(vim.fn.glob(semester_dir .. "/*", false, true)) do
		if vim.fn.isdirectory(path) == 1 then
			table.insert(slugs, vim.fn.fnamemodify(path, ":t"))
		end
	end
	table.sort(slugs)

	if #slugs == 0 then
		prompt_new_class(semester)
		return
	end

	table.insert(slugs, NEW_CLASS)

	vim.ui.select(slugs, {
		prompt = "Class (" .. semester .. "):",
		format_item = function(slug)
			return slug == NEW_CLASS and slug or class_label_from_slug(slug)
		end,
	}, function(choice)
		if not choice then
			return
		elseif choice == NEW_CLASS then
			prompt_new_class(semester)
		else
			open_class_note(semester, class_label_from_slug(choice))
		end
	end)
end

local function browse_notes()
	require("zk.api").list(nil, { select = { "title", "path", "absPath" } }, function(err, notes)
		assert(not err, tostring(err))

		local items = vim.tbl_map(function(note)
			local slug = note.path:match("^School/[^/]+/([^/]+)/")
			local title = note.title or note.path
			return {
				text = slug and (class_label_from_slug(slug) .. ": " .. title) or title,
				absPath = note.absPath,
			}
		end, notes)

		vim.ui.select(items, {
			prompt = "Notes:",
			format_item = function(item)
				return item.text
			end,
		}, function(choice)
			if choice then
				vim.cmd.edit(choice.absPath)
			end
		end)
	end)
end

return {
	{
		"zk-org/zk-nvim",
		name = "zk",
		ft = "markdown",
		cmd = {
			"ZkNew",
			"ZkNotes",
			"ZkNewFromTitleSelection",
			"ZkBacklinks",
			"ZkLinks",
			"ZkInsertLink",
			"ZkTags",
			"ZkMatch",
		},
		opts = {
			picker = "snacks_picker",
			lsp = {
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
				},
				auto_attach = { enabled = true },
			},
		},
		keys = {
			{
				"<leader>nc",
				new_class_note,
				desc = "New/open class daily note",
			},
			{
				"<leader>nn",
				function()
					vim.ui.input({ prompt = "Title: " }, function(title)
						if title and title ~= "" then
							require("zk").new({ title = title })
						end
					end)
				end,
				desc = "New note",
			},
			{
				"<leader>no",
				browse_notes,
				desc = "Browse notes",
			},
			{
				"<leader>nb",
				"<cmd>ZkBacklinks<cr>",
				desc = "Backlinks",
			},
			{
				"<leader>nl",
				"<cmd>ZkLinks<cr>",
				desc = "Outgoing links",
			},
			{
				"<leader>ni",
				"<cmd>ZkInsertLink<cr>",
				desc = "Insert link",
			},
			{
				"<leader>nt",
				"<cmd>ZkTags<cr>",
				desc = "Browse tags",
			},
			{
				"<leader>nm",
				"<cmd>ZkMatch<cr>",
				mode = "v",
				desc = "Search selected text",
			},
		},
	},
}
