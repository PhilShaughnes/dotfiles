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
local qf = {
	['C-k'] = { '<Plug>(qf_qf_previous)', 'quickfix previous' },
	['C-j'] = { '<Plug>(qf_qf_next)', 'quickfix next' },
	['<leader>k'] = { '<Plug>(qf_loc_previous)', 'loclist previous' },
	['<leader>j'] = { '<Plug>(qf_loc_next)', 'loclist next' },
	['\\\\'] = { '<Plug>(qf_qf_toggle)', 'quickfix toggle' },
	['\\|\\|'] = { '<Plug>(qf_loc_toggle)', 'loclist toggle' },
}
M.nmap(qf, {noremap = false})

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
-- local terminal_from_n = {
--	['<C-t>'] = {
--		name ='terminal',
--		t = { function() require('FTerm').toggle() end, "toggle popup terminal"},
--		s = { '<cmd>vsp term://bash<CR>', "open terminal in split" },
--	}
-- }
-- local terminal_from_t = {
--	['<C-t>'] = {
--		name ='terminal',
--		t = { function() require('FTerm').toggle() end, "toggle popup terminal"},
--		q = { function() require('FTerm').exit() end, "exit popup terminal"},
--		s = { '<cmd>q<CR>', "close terminal in split" },
--	}
-- }
-- M.nmap(terminal_from_n)
-- M.tmap(terminal_from_t)


--lsp
local toggle_state = true
local function lsp_diag_toggle()
	local toggled = not toggle_state
	toggle_state = toggled
	-- vim.diagnostic.config({virtual_text = toggled, underline = toggled})
	vim.diagnostic.config({virtual_text = toggled})
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
M.nmap(lsp_integrated)


-- nnn
local nnn_leader = {
	name = 'nnn file manager',
	n = {':call nnn#pick(getcwd())<CR>', "nnn window in root"},
	m = {":call nnn#pick(expand('%:p:h'))<CR>", "nnn window in dir of current file"},
	r = {
		":call nnn#pick(getcwd(), {'layout':{'left':'~20%'}})<CR>",
		"nnn sidebar in root"
	},
	l = {
		":call nnn#pick(expand('%:p:h'), {'layout':{'left':'~20%'}})<CR>",
		"nnn sidebar in dir of current file"
	},
}


-- fzf
local fzf = require('fzf-lua')
fzf.setup({keymap = { builtin = {
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
	-- f = { ':Files<CR>', 'find files' },
	-- b = { ':Buffers<CR>', 'find buffers' },
	-- c = { ':Commits<CR>', 'find commits' },
	-- t = { ':Rg<CR>', 'find text' },
	f = { function() fzf.files({fd_opts = "--color=never --type f --follow --exclude .git"}) end, 'find files' },
	h = { function() fzf.files() end, 'find hidden files' },
	b = { function() fzf.buffers() end, 'find buffers' },
	c = { function() fzf.git_commits() end, 'find commits' },
	g = { function() fzf.grep() end, 'grep text' },
	t = { function() fzf.grep_project() end, 'find text project' },
	l = { function() fzf.live_grep_native() end, 'find text live' },
	w = { function() fzf.grep_cword() end, 'find word under cursor' },
	W = { function() fzf.grep_cWORD() end, 'find WORD under cursor' },
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
M.vmap({['<leader>'] = vimwiki_vleader}, {noremap = false})

local vimwiki_leader = {
	name = 'vimwiki',
	x = {'<Plug>VimwikiToggleListItem', 'toggle list item'},
	['<bs>'] = {'<Plug>VimwikiGoBackLink', 'go back link'},
	['='] = {'<Plug>VimwikiAddHeaderLevel', 'add header level'},
	['-'] = {'<Plug>VimwikiRemoveHeaderLevel', 'remove header level'},
}
M.nmap({['<leader>'] = vimwiki_leader}, {noremap = false})

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
	[' '] = { ':set relativenumber!<bar> set list!<CR>',
		'toggle relative number and tabs' },
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
	['<C-j>'] = {':cn<CR>', 'down in quickfix window'},
	['<C-k>'] = {':cp<CR>', 'up in quickfix window'},
	['<C-q>'] = {'<C-w>w', 'cycle splits' },
	['<C-w>m'] = {':tab split<CR>', 'open current buffer in new tab'},
	-- ['c-h'] = {'5zh', 'scroll left 5 characters'},
	-- ['c-l'] = {'5zh', 'scroll left 5 characters'}
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
