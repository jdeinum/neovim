local vim = vim
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ";"


-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99
-- very basic "continue indent" mode (autoindent) is always on in neovim
-- could try smartindent/cindent, but meh.
-- vim.opt.cindent = true
-- XXX
-- vim.opt.cmdheight = 2
vim.opt.completeopt = 'menuone,noinsert,noselect'
-- not setting updatedtime because I use K to manually trigger hover effects
-- and lowering it also changes how frequently files are written to swap.
-- vim.opt.updatetime = 300
-- if key combos seem to be "lagging"
-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- vim.opt.timeoutlen = 300
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shortmess = 'WIcCFS'
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true

-- more useful diffs (nvim -d)
-- by ignoring whitespace
-- and using a smarter algorithm
vim.opt.diffopt:append('iwhite')
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
-- use the system clipboard for everything
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
-- quick-open
vim.keymap.set('', '<C-p>', '<cmd>Files<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<C-j>', '<Esc>')
vim.keymap.set('i', '<C-j>', '<Esc>')
vim.keymap.set('v', '<C-j>', '<Esc>')
vim.keymap.set('s', '<C-j>', '<Esc>')
vim.keymap.set('x', '<C-j>', '<Esc>')
vim.keymap.set('c', '<C-j>', '<Esc>')
vim.keymap.set('o', '<C-j>', '<Esc>')
vim.keymap.set('l', '<C-j>', '<Esc>')
vim.keymap.set('t', '<C-j>', '<Esc>')
vim.keymap.set('n', '<C-k>', '<Esc>')
vim.keymap.set('i', '<C-k>', '<Esc>')
vim.keymap.set('v', '<C-k>', '<Esc>')
vim.keymap.set('s', '<C-k>', '<Esc>')
vim.keymap.set('x', '<C-k>', '<Esc>')
vim.keymap.set('c', '<C-k>', '<Esc>')
vim.keymap.set('o', '<C-k>', '<Esc>')
vim.keymap.set('l', '<C-k>', '<Esc>')
vim.keymap.set('t', '<C-k>', '<Esc>')
-- Ctrl+h to stop searching
vim.keymap.set('v', '<C-h>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>nohlsearch<cr>')
-- <leader><leader> toggles between buffers
vim.keymap.set('n', '<leader><leader>', '<c-^>')
-- <leader>, shows/hides hidden characters
vim.keymap.set('n', '<leader>,', ':set invlist<cr>')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')
-- open new file adjacent to current file
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')

-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
-- handy keymap for replacing up to next _ (like in variable names)
vim.keymap.set('n', '<leader>m', 'ct_')
-- F1 is pretty close to Esc, so you probably meant Esc
vim.keymap.set('', '<F1>', '<Esc>')
vim.keymap.set('i', '<F1>', '<Esc>')

-- open lazy with <leader>ll
vim.keymap.set('n', '<leader>ll', '<cmd>Lazy<cr>')

-- highlight yank
vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
	checker = {
		notify = false,
	},
	spec = {
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
			config = function()
				vim.cmd [[colorscheme tokyonight]]
			end
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = { "rust", "lua", "c", "python", "go" },
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
			keys = {
			}
		},
		{
			"williamboman/mason.nvim",
			opts = {},
			keys = {
				{ "<leader>mm", "<cmd>Mason<cr>", mode = "n" },
			}
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {},
		},
		{

			'neovim/nvim-lspconfig',
			config = function()
				-- Setup language servers.
				local lspconfig = require('lspconfig')

				-- Rust
				lspconfig.rust_analyzer.setup {
					-- Server-specific settings. See `:help lspconfig-setup`
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
				}

				-- Bash LSP
				local configs = require 'lspconfig.configs'
				if not configs.bash_lsp and vim.fn.executable('bash-language-server') == 1 then
					configs.bash_lsp = {
						default_config = {
							cmd = { 'bash-language-server', 'start' },
							filetypes = { 'sh' },
							root_dir = require('lspconfig').util.find_git_ancestor,
							init_options = {
								settings = {
									args = {}
								}
							}
						}
					}
				end
				if configs.bash_lsp then
					lspconfig.bash_lsp.setup {}
				end

				lspconfig.lua_ls.setup {}
				lspconfig.clangd.setup {}
				lspconfig.pyright.setup {}
				lspconfig.ansiblels.setup {
					filetypes = { "yaml" }
				}
				lspconfig.jsonls.setup {}
				lspconfig.dockerls.setup {}
				lspconfig.yamlls.setup {}
				lspconfig.tsserver.setup {}
				lspconfig.html.setup {}

				-- Global mappings.
				-- See `:help vim.diagnostic.*` for documentation on any of the below functions
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
				vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

				-- Use LspAttach autocommand to only map the following keys
				-- after the language server attaches to the current buffer
				vim.api.nvim_create_autocmd('LspAttach', {
					group = vim.api.nvim_create_augroup('UserLspConfig', {}),
					callback = function(ev)
						-- Enable completion triggered by <c-x><c-o>
						vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

						-- Buffer local mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local opts = { buffer = ev.buf }
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
						vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
						vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
						vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
						vim.keymap.set('n', '<leader>wl', function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, opts)
						vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
						vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
						vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
						vim.keymap.set('n', '<leader>cf', function()
							vim.lsp.buf.format { async = true }
						end, opts)

						local client = vim.lsp.get_client_by_id(ev.data.client_id)
					end,
				})
			end,
			keys = {},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"folke/trouble.nvim",
			opts = { focus = true },
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false winposition=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				'neovim/nvim-lspconfig',
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require 'cmp'
				cmp.setup({
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'path' },
					}),
					experimental = {
						ghost_text = true,
					},
				})

				-- Enable completing paths in :
				cmp.setup.cmdline(':', {
					sources = cmp.config.sources({
						{ name = 'path' }
					})
				})
			end
		},
		{
			"kylechui/nvim-surround",
			version = "*",
			event = "VeryLazy",
			opts = {}
		},
		{
			"chentoast/marks.nvim",
			opts = {}
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")
				harpoon:setup()
			end,
			keys = {
			}
		},
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.8',
			cmd = 'Telescope',
			dependencies = { 'nvim-lua/plenary.nvim' },
			opts = {},
			keys = {
				{ '<localleader>ff', '<cmd>Telescope find_files<CR>',                    desc = 'Find files' },
				{ '<localleader>gf', '<cmd>Telescope grep_string<CR>',                   desc = 'Find Word' },
				{ '<localleader>gg', '<cmd>Telescope live_grep<CR>',                     desc = 'Grep' },
				{ '<localleader>b',  '<cmd>Telescope buffers show_all_buffers=true<CR>', desc = 'Buffers' },
				{ '<localleader>m',  '<cmd>Telescope marks<CR>',                         desc = 'Marks' },
				{ '<localleader>u',  '<cmd>Telescope spell_suggest<CR>',                 desc = 'Spell suggest' },
				{ '<localleader>x',  '<cmd>Telescope oldfiles<CR>',                      desc = 'Old files' },
				{ '<localleader>;',  '<cmd>Telescope command_history<CR>',               desc = 'Command history' },
				{ '<localleader>:',  '<cmd>Telescope commands<CR>',                      desc = 'Commands' },
				{ '<localleader>/',  '<cmd>Telescope search_history<CR>',                desc = 'Search history' },
				{ '<leader>/',       '<cmd>Telescope current_buffer_fuzzy_find<CR>',     desc = 'Buffer find' },
				{ '<leader>sk',      '<cmd>Telescope keymaps<CR>',                       desc = 'Key Maps' },
				{ '<leader>sm',      '<cmd>Telescope man_pages<CR>',                     desc = 'Man Pages' },
			},
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			},
			keys = {
				{
					'<LocalLeader>e',
					'<cmd>Neotree filesystem left toggle dir=./<CR>',
					desc = 'Explorer NeoTree Toggle',
				},
				{
					'<LocalLeader>a',
					'<cmd>Neotree filesystem left reveal dir=./<CR>',
					desc = 'Explorer NeoTree Reveal',
				},
			},
			deactivate = function()
				vim.cmd([[Neotree close]])
			end,
			opts = {
				close_if_last_window = true,

				source_selector = {
					winbar = false,
					show_scrolled_off_parent_node = true,
					padding = { left = 1, right = 0 },
					sources = {
						{ source = 'filesystem', display_name = '  Files' }, --       
						{ source = 'buffers', display_name = '  Buffers' }, --        
						{ source = 'git_status', display_name = ' 󰊢 Git' }, -- 󰊢      
					},
				},

				event_handlers = {
					-- Close neo-tree when opening a file.
					{
						event = 'file_opened',
						handler = function()
							require('neo-tree').close_all()
						end,
					},
				},

				default_component_configs = {
					indent = {
						padding = 0,
					},
					icon = {
						folder_closed = '',
						folder_open = '',
						folder_empty = '',
						folder_empty_open = '',
						default = '',
					},
					modified = {
						symbol = '•',
					},
					name = {
						trailing_slash = true,
						highlight_opened_files = true,
						use_git_status_colors = false,
					},
					git_status = {
						symbols = {
							-- Change type
							added = 'A',
							deleted = 'D',
							modified = 'M',
							renamed = 'R',
							-- Status type
							untracked = 'U',
							ignored = 'I',
							unstaged = '',
							staged = 'S',
							conflict = 'C',
						},
					},
				},
				window = {
					width = 25,
					mappings = {
						['q'] = 'close_window',
						['?'] = 'noop',
						['<Space>'] = 'noop',

						['g?'] = 'show_help',
						['<2-LeftMouse>'] = 'open',
						['<CR>'] = 'open_with_window_picker',
						['l'] = 'open_drop',
						['h'] = 'close_node',
						['C'] = 'close_node',
						['z'] = 'close_all_nodes',
						['<C-r>'] = 'refresh',

						['s'] = 'noop',
						['sv'] = 'open_split',
						['sg'] = 'open_vsplit',
						['st'] = 'open_tabnew',

						['c'] = { 'copy', config = { show_path = 'relative' } },
						['m'] = { 'move', config = { show_path = 'relative' } },
						['a'] = { 'add', nowait = true, config = { show_path = 'relative' } },
						['N'] = { 'add_directory', config = { show_path = 'relative' } },
						['d'] = 'noop',
						['dd'] = 'delete',
						['r'] = 'rename',
						['y'] = 'copy_to_clipboard',
						['x'] = 'cut_to_clipboard',
						['P'] = 'paste_from_clipboard',
						['<S-Tab>'] = 'prev_source',
						['<Tab>'] = 'next_source',

						['p'] = {
							'toggle_preview',
							nowait = true,
							config = { use_float = true },
						},
					},
				},
				filesystem = {
					window = {
						mappings = {
							['H'] = 'toggle_hidden',
							['/'] = 'noop',
							['f'] = 'fuzzy_finder',
							['F'] = 'filter_on_submit',
							['<C-x>'] = 'clear_filter',
							['<C-c>'] = 'clear_filter',
							['<BS>'] = 'navigate_up',
							['.'] = 'set_root',
							['[g'] = 'prev_git_modified',
							[']g'] = 'next_git_modified',
						},
					},
					group_empty_dirs = true,
					use_libuv_file_watcher = true,
					bind_to_cwd = false,
					cwd_target = {
						sidebar = 'window',
						current = 'window',
					},

					filtered_items = {
						visible = false,
						show_hidden_count = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							'.git',
							'.hg',
							'.svc',
							'.DS_Store',
							'thumbs.db',
							'.sass-cache',
							'node_modules',
							'.pytest_cache',
							'.mypy_cache',
							'__pycache__',
							'.stfolder',
							'.stversions',
						},
						never_show = {},
					},
				},
				buffers = {
					bind_to_cwd = false,
					window = {
						mappings = {
							['<BS>'] = 'navigate_up',
							['.'] = 'set_root',
							['dd'] = 'buffer_delete',
						},
					},
				},
			},
		},
		{
			'nvim-lualine/lualine.nvim',
			dependencies = {
				'nvim-tree/nvim-web-devicons',
			},
			opts = {}
		},
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "search_count",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
						},
						opts = { skip = true },
					},

				},

			},
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			}
		},
		{
			"lewis6991/gitsigns.nvim",
			opts = {}
		},
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
		},
		{
			"windwp/nvim-ts-autotag",
			opts = {}

		},
		{
			'numToStr/Comment.nvim',
			opts = {
			}
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			opts = {}
		},
		{
			'ggandor/leap.nvim',
			config = function()
				require('leap').create_default_mappings()
			end
		},
		{
			'stevearc/conform.nvim',
			opts = {},
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "isort", "black" },
						rust = { "rustfmt", lsp_format = "fallback" },
					},
				})
			end,
			keys = {
				-- {"<leader>cf", require("conform").format()}
			}
		},
	},
})
