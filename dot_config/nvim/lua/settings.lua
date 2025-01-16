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
g.editorconfig = true -- true is default
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
-- set.relativenumber = true
-- set.cursorcolumn = true
set.cursorline = true
set.cursorlineopt = "number"
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
-- set.completeopt = { 'menu', 'menuone', 'popup', 'noinsert' }
set.completeopt = { 'menu', 'fuzzy', 'longest', 'noinsert' }
set.pumheight = 10
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
set.omnifunc = 'lspcomplete#Complete'
set.wildmode = { 'longest:full', 'full' }

set.termguicolors = true
-- set.background = 'light'

vim.g.zenbones_compat = 1

-- if os.getenv('THEME') == 'dark' then
-- 	set.background = 'dark'
-- end

-- set.rulerformat = '%35(%t ' ..
-- 		"%{get(b:,'gitsigns_status','')}" ..
-- 		'%<%= %p%%%=%-l:%v' ..
-- 		' %L' ..
-- 		'%)'
-- set.rulerformat = '%35(%t ' ..
-- 		"%{get(b:,'gitsigns_status','')}" ..
-- 		-- '%<%= %p%%%=%-l:%v' ..
-- 		'%=%l:%v%=%p%%' ..
-- 		-- ' %L' ..
-- 		'%)'

-- default, with added line number
-- set.rulerformat = '%20(%l,%c%V%=%p%% %L%)'
-- adds file name a slightly different line num/col format and total lines
-- set.rulerformat = '%25(%t %l:%v%=%p%% %L%)'
-- just tweaks the format
set.rulerformat = '%10(%l:%v%=%p%%%)'
