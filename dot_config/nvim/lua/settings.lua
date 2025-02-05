local g = vim.g
local set = vim.opt
-- local nvim_dir = vim.fn.expand("$HOME/.config/nvim")
local tmpdir = vim.fn.expand("$TMPDIR")

-- don't load these built-in plugins
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.loaded_matchit = 1

-- vim.g.clipboard = {
-- 	name = 'OSC 52',
-- 	copy = {
-- 		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
-- 	},
-- 	paste = {
-- 		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
-- 	},
-- }

g.mapleader = " "
g.vimsyn_embeded = "lr"

set.backup = false
set.swapfile = false
set.autoread = true
set.autowrite = true
set.gdefault = true
set.hidden = true
set.hlsearch = true
set.incsearch = true
set.inccommand = "nosplit"
-- set.inccommand = 'split'
set.lazyredraw = true
set.linebreak = true
set.wrap = false
set.number = true
set.cursorline = true
set.cursorlineopt = "number"
set.ruler = true
set.splitbelow = true
set.splitright = true
set.ignorecase = true
set.smartcase = true
set.signcolumn = "yes"
set.colorcolumn = { 80 }
set.scrolloff = 10
set.laststatus = 3
set.mouse = "a"
set.shortmess = "at"
set.expandtab = false
-- set.expandtab = true
set.shiftround = true
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.conceallevel = 2
set.clipboard = "unnamed"
-- set.completeopt = { 'menu', 'menuone', 'popup', 'noinsert' }
set.completeopt = { "menu", "noselect", "fuzzy", "noinsert" }
set.pumheight = 10
set.list = true
set.listchars = {
	space = "·",
	-- eol = "↴",
	-- tab = "▸▹",
	-- tab = "▹ ",
	tab = "❘⠀",
	trail = "·",
	nbsp = "·",
}
set.undofile = true
set.undodir = tmpdir
-- set.undodir = nvim_dir .. '/.vimundo'
set.grepprg = "rg --smart-case --vimgrep"
set.grepformat = "%f:%l:%c:%m"
-- set.omnifunc = 'lspcomplete#Complete'
set.wildmode = { "longest:full", "full" }
set.rulerformat = "%10(%l:%v%=%p%%%)"

set.termguicolors = true
vim.cmd("colorscheme firelite")
