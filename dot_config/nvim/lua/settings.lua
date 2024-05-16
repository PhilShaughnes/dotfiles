local g = vim.g
local set = vim.opt
local nvim_dir = vim.fn.expand("$HOME/.config/nvim")
local tmpdir = vim.fn.expand("$TMPDIR")

-- don't load these built-in plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- g.loaded_matchit = 1

g.mapleader = ' '
g.vimsyn_embeded = 'lr'
-- g.editorconfig = true -- true is default
-- g.did_load_filetypes = 1
-- g.did_load_filetypes = 0
-- g.do_filetype_lua = 1

set.backup = false
set.swapfile = false
set.autoread = true
set.autowrite = true
set.gdefault = true
set.hidden = true
set.hlsearch = true
set.incsearch = true
set.inccommand = 'nosplit'
-- set.inccommand = 'split'
set.lazyredraw = true
set.linebreak = true
set.wrap = false
set.number = true
set.relativenumber = true
-- set.cursorcolumn = true
-- set.cursorline = true
set.ruler = true
set.splitbelow = true
set.splitright = true
set.ignorecase = true
set.smartcase = true
set.signcolumn = 'yes'
set.colorcolumn = { 80 }
set.scrolloff = 10
set.laststatus = 3
set.mouse = 'a'
set.shortmess = 'at'
set.expandtab = false
-- set.expandtab = true
set.shiftround = true
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.conceallevel = 2
set.thesaurus:append(nvim_dir .. '/thes/thesaurii.txt')
set.clipboard = 'unnamed'
-- set.completeopt = { 'menu', 'preview' }
set.completeopt = { 'menu', 'menuone', 'noselect' }
set.list = true
set.listchars = {
	space = "·",
	-- eol = "↴",
	-- tab = "▸▹",
	-- tab = "▹ ",
	tab = "❘⠀",
	trail = "·",
	nbsp = "·"
}
set.undofile = true
set.undodir = tmpdir
-- set.undodir = nvim_dir .. '/.vimundo'
set.grepprg = 'rg --smart-case --vimgrep'
set.grepformat = '%f:%l:%c:%m'
set.omnifunc = 'syntaxcomplete#Complete'

set.termguicolors = true
set.background = 'dark'

-- set.statusline = '%f '..
--   "%{get(b:,'gitsigns_status','')}"..
--   '%<%= %p%% | %-l:%v |'..
--   ' %L'

vim.g.zenbones_solid_line_nr = true
vim.g.zenbones_darken_comments = 45
vim.g.bones_compat = 1
