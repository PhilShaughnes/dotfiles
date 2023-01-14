local cmd = vim.cmd
-- assume which key is installed
-- maybe consider using https://github.com/mrjones2014/legendary.nvim
local M = {}
local h = require('helpers')

local wk = require("which-key")
wk.setup({plugins = {spelling = {enabled = true}}})

function M.map(mode, table, opts)
	local options = {noremap = true, silent = true, mode = mode}
	if opts then options = vim.tbl_extend('force', options, opts) end
	wk.register(table, options)
end

function M.nmap(table, opts) M.map('n', table, opts) end
function M.tmap(table, opts) M.map('t', table, opts) end
function M.vmap(table, opts) M.map('v', table, opts) end
function M.imap(table, opts) M.map('i', table, opts) end
function M.oxmap(table, opts)
	M.map('x', table, opts)
	M.map('o', table, opts)
end

M.line_end_toggle = function (char)
	
  local fn = vim.fn
  local line = fn.getline '.'
  local newline = ''

  if char == string.sub(line, #line) then
    newline = line:sub(1, -2)
  else
    newline = line .. char
  end

  return fn.setline('.', newline)
end

--qf
local toggle_qf = function ()
	if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
		cmd("cclose")
	else
		cmd("copen")
	end
end

local qf = {
	['<C-k>'] = { ':cprev', 'quickfix previous' },
	['<C-j>'] = { ':cnext', 'quickfix next' },
	['<leader>k'] = { 'lprev', 'loclist previous' },
	['<leader>j'] = { 'lnext', 'loclist next' },
	['\\\\'] = { toggle_qf, 'quickfix toggle' },
}
-- dump(qf)
-- M.nmap('<C-k>', ':cprev', 'quickfix previous')
-- M.nmap(qf)

function M.mmap(mode, rhs, lhs, opts)
	local options = {remap = false, silent = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.keymap.set(mode, rhs, lhs, options)
end

M.mmap('n', '<C-k>',     ':cprev',  { desc = 'quickfix previous' })
M.mmap('n', '<C-j>',     ':cnext',  { desc = 'quickfix next' })
M.mmap('n', '<leader>k', 'lprev',   { desc = 'loclist previous' })
M.mmap('n', '<leader>j', 'lnext',   { desc = 'loclist next' })
M.mmap('n', '\\\\',      toggle_qf, { desc = 'quickfix toggle' })

-- terminal
local term = {
	['<C-t>;'] = { '<Cmd>exe v:count1 . "ToggleTerm size=50"<CR>', "prefix terminal" },
	['<C-t>j'] = { '<Cmd>1ToggleTerm<CR>', "terminal 1" },
	['<C-t>k'] = { '<Cmd>2ToggleTerm<CR>', "terminal 2" },
	['<C-t>h'] = { '<Cmd>ToggleTermToggleAll<CR>', "toggle all terminal" },
}

local tterm = {
	['<C-q>'] = {h.t([[<C-\><C-n><C-W>w]]), 'cycle splits'},
	["<C-r>"] = {h.t([[<C-\><C-n>]]), 'normal mode'},
}
M.tmap(h.merge(term, tterm))
M.nmap(term)
M.vmap({['<C-t>l'] = {':ToggleTermSendVisualSelection 2<CR>', "send visual selection to terminal"}})

--lsp
local toggle_state = true
local function lsp_diag_toggle()
	local toggled = not toggle_state
	toggle_state = toggled
	-- vim.diagnostic.config({virtual_text = toggled, underline = toggled})
	vim.diagnostic.config({virtual_text = toggled, underline = toggled})
end
local lsp_integrated = {
	['[d'] = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
	[']d'] = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
	K = { function() vim.lsp.buf.hover() end, "documentation" },
	-- gd = { function() vim.lsp.buf.definition() end, "show definition" },
	gr = { function() vim.lsp.buf.references() end, "references" },
}
local lsp_leader = {
	name = 'lsp',
	l = { function() vim.diagnostic.open_float() end, "show diagnostics" },
	e = { function() lsp_diag_toggle() end, "toggle some virtual text" },
	q = { function() vim.diagnostic.setqflist() end, "all diagnostics in qf" },
	r = { function() vim.lsp.buf.references() end, "references" },
	d = { function() vim.lsp.buf.definition() end, "show definition" },
	D = { function() vim.lsp.buf.declaration() end, "show declaration" },
	i = { function() vim.lsp.buf.implementation() end, "show declaration" },
	k = { function() vim.lsp.buf.hover() end, "documentation" },
	p = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
	n = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
	a = { ':CodeActionMenu<CR>', "code actions menu" },
}
-- M.nmap(lsp_integrated)
M.mmap('n', '[d', vim.diagnostic.goto_prev, { desc = 'prev diagnostic'})
M.mmap('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic'})
M.mmap('n', 'K',  vim.lsp.buf.hover,        { desc = 'documentation'})
M.mmap('n', 'gd', vim.lsp.buf.definition,   { desc = 'show definition' })
M.mmap('n', 'gr', vim.lsp.buf.references,   { desc = 'references'})

-- nnn
local nnn_leader = {
	name = 'nnn file manager',
	n = {':NnnPicker<CR>', "nnn window in root"},
	m = {":NnnPicker %:p:h<CR>", "nnn window in dir of current file"},
	r = { ":NnnExplorer<CR>", "nnn sidebar in root" },
	l = { ":NnnExplorer %:p:h<CR>", "nnn sidebar in dir of current file" },
}

-- fzf
local fzf = require('fzf-lua')
local insert_mk_link = function (selected, _)
  local line = vim.api.nvim_get_current_line()
  local position = vim.api.nvim_win_get_cursor(0)
  local row = position[1]
  local col = position[2]
  local cursor_word = vim.fn.expand('<cword>')
  local left, right = string.find(line, cursor_word, nil, true)
  while right < col do
    left, right = string.find(line, cursor_word, right, true)
  end
  local replacement = {'['..cursor_word..']'..'('..selected[1]..')'}

  vim.api.nvim_buf_set_text(
    0, row - 1, left - 1, row - 1, right, replacement
  )
end

fzf.setup({
	keymap = { builtin = {
	["<C-f>"]        = "toggle-fullscreen",
	-- Only valid with the 'builtin' previewer
	["<C-w>"]        = "toggle-preview-wrap",
	["<C-p>"]        = "toggle-preview",
	-- Rotate preview clockwise/counter-clockwise
	["<C-l>"]        = "toggle-preview-ccw",
	["<C-h>"]        = "toggle-preview-cw",
	["<S-down>"]     = "preview-page-down",
	["<S-up>"]       = "preview-page-up",
	["<S-left>"]     = "preview-page-reset",
}}})

local find_leader = {
	name = 'find',
	f = { function() fzf.files({
			fd_opts = "--color=never --type f --follow --exclude .git", }) 
		end, 'find files', },
	a = { function() fzf.files({
			fd_opts = "--color=never --type f --follow --no-ignore"})
		end, 'find all files' },
	h = { function() fzf.files() end, 'find hidden files' },
	b = { function() fzf.buffers() end, 'find buffers' },
	c = { function() fzf.git_commits() end, 'find commits' },
	g = { function() fzf.grep() end, 'grep text' },
	t = { function() fzf.grep_project() end, 'find text project' },
	l = { function() fzf.live_grep_native() end, 'find text live' },
	w = { function() fzf.grep_cword() end, 'find word under cursor' },
	W = { function() fzf.grep_cWORD() end, 'find WORD under cursor' },
	m = { function() fzf.files({
			-- cwd = '~/wiki',
			fd_opts = '--base-directory ~/wiki --type f',
			actions = {['default'] = insert_mk_link},
		}) end,
		'create markdown link from filename',
	},
}
M.vmap({ ['<leader>f'] = {
	name = 'find',
	f = {function() fzf.grep_visual() end, 'grep visual selection'},
}})

-- vimwiki
local vimwiki_vleader = {
	name = 'vimwiki',
	x = {'<Plug>VimwikiToggleListItem', 'toggle list item'},
}
-- M.vmap({['<leader>'] = vimwiki_vleader}, {noremap = false})

local vimwiki_leader = {
	name = 'vimwiki',
	x = {'<Plug>VimwikiToggleListItem', 'toggle list item'},
	['<bs>'] = {'<Plug>VimwikiGoBackLink', 'go back link'},
	['='] = {'<Plug>VimwikiAddHeaderLevel', 'add header level'},
	['-'] = {'<Plug>VimwikiRemoveHeaderLevel', 'remove header level'},
}
-- M.nmap({['<leader>'] = vimwiki_leader}, {noremap = false})

-- gitsigns
local gs = require('gitsigns')
local gitsigns_leader = {
	r = {function() gs.reset_hunk() end, "reset hunk"},
	p = {gs.preview_hunk, "preview hunk"},
	d = {gs.diffthis, "diffthis"},
	D = {function() gs.diffthis('~') end, "diffthis"},
	c = {function() gs.blame_line{full=true} end, "show commit info"},
	b = {function() gs.toggle_current_line_blame() end, "toggle line blame"},
}

M.oxmap({ ['ih'] = {":<C-U>Gitsigns select_hunk<CR>", "select hunk"} })

local nv_gitsigns = {
	["<leader>hs"] = {':Gitsigns stage_hunk<CR>', "stage hunk"},
	["<leader>hr"] = {':Gitsigns reset_hunk<CR>', "stage hunk"},
}
M.nmap(nv_gitsigns, {silent = false})
M.vmap(nv_gitsigns, {silent = false})

local gitsigns = {
	[']c'] = {function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end,
	"next hunk"},
	['[c'] = {function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end,
	"prev hunk"},
}
M.nmap(gitsigns, {silent = false})


local git_leader = {
	g = {':Git<CR>', "open git view"},
}


local leader = {
	name = 'leader',
	l = lsp_leader,
	n = nnn_leader,
	f = find_leader,
	h = gitsigns_leader,
	g = git_leader,
	m = {
		name = 'markdown',
	},
	[","] = {function() M.line_end_toggle(',') end, "toggle , at end of line"},
	[";"] = {function() M.line_end_toggle(';') end, "toggle , at end of line"},
}
M.nmap({['<leader>'] = leader})
local verbose_leader = {
	b = { ':ls<CR>:b<space>', "show buffers" },
	-- [' '] = { ':set relativenumber!<bar> set list!<CR>',
	-- 	'toggle relative number and tabs' },
	[' '] = { ':set hlsearch!<CR>',
		'toggle search highlight' },
	['/'] = { [[:'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/]],
		'replace all word in paragraph' },
	['%'] = { [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
		'replace all word in buffer' },
}
M.nmap({['<leader>'] = verbose_leader}, {silent = false})

-- standard keymaps
M.nmap({
	j = {'gj', 'down'},
	k = {'gk', 'up'},
	gV = {'`[v`]', 'highlight last inserted text'},
	H = {'^', 'go to begining of line'},
	L = {'$', 'go to end of line'},
	Q = {'@q', 'run default (q) macro'},
	Y = {'y$', 'yank to the end of the line'},

	["'"] = {'`', 'go to mark location (set with letter m)'},
	['<bs>'] = {':b#<CR>', 'switch to last buffer'},

	['z/'] = { ':set cursorcolumn! <bar> set cursorline!<CR>',
		'toggle cursor line and column highlight' },
	['z.'] = { ':set relativenumber!<bar> set list!<CR>',
		'toggle relative number and tabs' },
	['z,'] = { ':set hlsearch!<CR>',
		'toggle search highlight' },
	['<C-j>'] = {':cn<CR>', 'down in quickfix window'},
	['<C-k>'] = {':cp<CR>', 'up in quickfix window'},
	['<C-q>'] = {'<C-w>w', 'cycle splits' },
	['<C-w>m'] = {':tab split<CR>', 'open current buffer in new tab'},
	-- ['<c-h>'] = {'5zh', 'scroll left 5 characters'},
	-- ['<c-l>'] = {'5zh', 'scroll left 5 characters'}
})
M.vmap({
	Q = {'@q', 'run default (q) macro on selection'},
	J = {[[:m '>+1<CR>gv=gv]], 'move visual block down'},
	K = {[[:m '<-2<CR>gv=gv]], 'move visual block up'},
	['<'] = {'<gv', 'un-indent'},
	['>'] = {'>gv', 'indent'},
})
M.imap({
	['<C-e>'] = {'<esc>ea', "like 'e' but in insert"},
	['<C-t>'] = {'<esc>/[)}"\'\\]>]<CR>:nohlsearch<CR>a', "move outside next closing thing"},
})

return M
