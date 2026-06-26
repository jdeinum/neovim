local vim = vim
local opt = vim.opt

-- Folding

opt.foldenable = false

opt.foldmethod = "manual"

opt.foldlevelstart = 99

-- Completion

opt.completeopt = "menuone,noinsert,noselect"

-- Interface

opt.scrolloff = 2

opt.wrap = false

opt.signcolumn = "yes"

opt.relativenumber = true

opt.number = true

opt.splitright = true

opt.splitbelow = true

-- History and files

opt.undofile = true

-- Indentation and tabs

opt.shiftwidth = 4

opt.softtabstop = 4

opt.tabstop = 4

opt.expandtab = true

-- Search

opt.ignorecase = true

opt.smartcase = true

opt.wildmode = "list:longest"

opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"

-- Appearance

opt.vb = true

opt.textwidth = 80

opt.colorcolumn = "80"

opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

-- Disable character concealing
opt.conceallevel = 0

-- Clipboard
-- Neovim auto-detects wl-copy/wl-paste on PATH and wires up the correct
-- flags (incl. --no-newline) for proper characterwise/linewise paste.

opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Other settings

opt.shortmess = "WIcCFS"

-- Performance - reduce flicker
opt.updatetime = 250  -- Faster updates for better responsiveness
opt.redrawtime = 1500  -- Allow more time for syntax highlighting

-- Diff settings

opt.diffopt:append("iwhite")

opt.diffopt:append("algorithm:histogram")

opt.diffopt:append("indent-heuristic")
