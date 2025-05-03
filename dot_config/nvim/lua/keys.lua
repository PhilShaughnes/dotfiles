local cmd = vim.cmd
-- assume which key is installed
-- maybe consider using https://github.com/mrjones2014/legendary.nvim
local M = {}
local h = require('helpers')
local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end


local haswk, wk = pcall(require, "which-key")
local haskm, km = pcall(require, "key-menu")
-- local haswk, wk = false, false
-- local haskm, km = false, false
if haswk then wk.setup({ plugins = { spelling = { enabled = true } } }) end


-- HELPER FUNCTIONS
local function set_group(mode, keys, desc)
	if haswk then
		wk.add({ keys, group = desc })
	elseif haskm then
		km.set(mode, keys, { desc = desc })
	else
		vim.notify_once('which-key and key-menu not available')
	end
end

M.map = h.map
M.nmap = h.mapper('n')
M.tmap = h.mapper('t')
M.vmap = h.mapper('v')
M.xmap = h.mapper('x')
M.imap = h.mapper('i')
M.oxmap = h.mapper({ 'x', 'o' })

M.line_end_toggle = function(char)
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
local toggle_qf = function()
	if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
		cmd("cclose")
	else
		cmd("copen")
	end
end

-- replaces niceblock like functionality
M.xmap('A', function()
	if vim.fn.mode() == 'V' then h.feedkeys '<C-v>0o$A' else h.feedkeys 'A' end
end, { expr = true, desc = 'better A in vis line mode' })

M.xmap('I', function()
	if vim.fn.mode() == 'V' then h.feedkeys '<C-v>0I' else h.feedkeys 'I' end
end, { expr = true, desc = 'better I in vis line mode' })

M.map({ 'n', 'x' }, '<leader>k', h.go_indent_start, { desc = "go indent start" })
M.map({ 'n', 'x' }, '<leader>j', h.go_indent_end, { desc = "go indent end" })
M.map({ 'n', 'x' }, '[[', h.go_indent_start, { desc = "go indent start" })
M.map({ 'n', 'x' }, ']]', h.go_indent_end, { desc = "go indent end" })

M.imap('<C-Space>', '<C-x><C-o>', { desc = 'lsp completion' })

M.imap('<C-n>', function()
	if pumvisible() then
		h.feedkeys '<C-n>'
	elseif vim.bo.omnifunc == '' then
		h.feedkeys '<C-x><C-n>'
	else
		h.feedkeys '<C-x><C-o>'
	end
end, { desc = 'Trigger/select next completion' })

M.nmap('<C-k>', ':cprev<CR>', { desc = 'quickfix previous' })
M.nmap('<C-j>', ':cnext<CR>', { desc = 'quickfix next' })
M.nmap('\\\\', toggle_qf, { desc = 'quickfix toggle' })

M.nmap("<leader>,", function() M.line_end_toggle(',') end, { desc = "toggle , at end of line" })
M.nmap("<leader>;", function() M.line_end_toggle(';') end, { desc = "toggle ; at end of line" })
M.imap("<C-o>,", function() M.line_end_toggle(',') end, { desc = "toggle , at end of line" })
M.imap("<C-o>;", function() M.line_end_toggle(';') end, { desc = "toggle ; at end of line" })

M.nmap('<leader>:', ':lua ', { desc = 'command mode with lua', silent = false })
M.nmap('<leader>b', ':ls<CR>:b<space>', { desc = "show buffers", silent = false })
M.nmap('<leader>s', ':set hlsearch!<CR>', { desc = 'toggle search highlight' })
M.nmap('<leader>/', [[:'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/]],
	{ desc = 'replace all word in paragraph', silent = false })
M.nmap('<leader>%', [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
	{ desc = 'replace all word in buffer', silent = false })

M.nmap('<leader><CR>', [[<ESC>/<CR>"_c4l]], { desc = "go to next <++>" })
M.nmap('<leader><space>', [[<ESC>?<++><CR>"_c4l]], { desc = "go to prev <++>" })

M.nmap('j', 'gj', { desc = 'down' })
M.nmap('k', 'gk', { desc = 'up' })
M.nmap('gV', '`[v`]', { desc = 'highlight last inserted text' })
-- M.nmap('H', '^', { desc = 'go to begining of line' })
M.nmap('gh', '^', { desc = 'go to begining of line' })
-- M.nmap('L', '$', { desc = 'go to end of line' })
M.nmap('gl', '$', { desc = 'go to end of line' })
M.map({ 'n', 'v' }, 'Q', '@q', { desc = 'run default (q) macro' })
M.nmap('R', '"0p', { desc = 'Paste contents of 0 register' })
M.vmap('R', '"ddp', { desc = 'Replace with contents of * register' })
M.nmap('Y', 'y$', { desc = 'yank to the end of the line' })
M.nmap('[<space>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', { desc = "add line above" })
M.nmap(']<space>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', { desc = "add line below" })

M.nmap("'", '`', { desc = 'go to mark location (set with letter m)' })
M.nmap('<bs>', ':b#<CR>', { desc = 'switch to last buffer' })

-- args list instead of arrow or harpoon
M.nmap('gn', ':n<CR>', { desc = 'next buffer on list' })
M.nmap('gp', ':N<CR>', { desc = 'previous buffer on list' })
M.nmap('gm', ':la#<CR>', { desc = 'last arg buffer' });
M.nmap(',1', ':rew<CR>', { desc = 'first arg buffer' })
M.nmap(',2', ':argu 2<CR>', { desc = 'second arg buffer' })
M.nmap(',3', ':argu 3<CR>', { desc = 'third arg buffer' })
M.nmap(',4', ':argu 4<CR>', { desc = 'fourth arg buffer' })
M.nmap(',,', ':args<CR>', { desc = 'show arglist' })
M.nmap(',s', function()
	-- made dir if not exists
	-- write arglist to file if not exists
end, { desc = 'save arglist' })
M.nmap(',l', function()
	-- load list of saved arglists
	-- 'e argsavedir/*<C-d>'
end, { desc = 'load arglist' })
M.nmap(',a', ':argadd %<CR>', { desc = 'add to arglist' })
M.nmap(',d', ':argdelete %<CR>', { desc = 'delete from arglist' })
M.nmap(',c', ':argdelete *<CR>', { desc = 'clear arglist' })
M.nmap('<leader>1', ':rew<CR>', { desc = 'first arg buffer' })
M.nmap('<leader>2', ':argu 2<CR>', { desc = 'second arg buffer' })
M.nmap('<leader>3', ':argu 3<CR>', { desc = 'third arg buffer' })
M.nmap('<leader>4', ':argu 4<CR>', { desc = 'fourth arg buffer' })
M.nmap('<leader>as', ':args<CR>', { desc = 'show arglist' })
M.nmap('<leader>aa', ':argadd %<CR>', { desc = 'add to arglist' })
M.nmap('<leader>ad', ':argdelete %<CR>', { desc = 'delete from arglist' })
M.nmap('<leader>ac', ':argdelete *<CR>', { desc = 'clear arglist' })

M.nmap('z/', ':set cursorcolumn! <bar> set cursorline!<CR>', { desc = 'toggle cursor line and column highlight' })
M.nmap('z.', ':set list!<CR>', { desc = 'toggle show tabs' })
M.nmap('z,', ':set relativenumber!<CR>', { desc = 'toggle relative number' })
-- M.nmap('z,', ':set hlsearch!<CR>', { desc = 'toggle search highlight' })
M.nmap('<C-q>', '<C-w>w', { desc = 'cycle splits' })
M.nmap('<C-w>m', ':tab split<CR>', { desc = 'open current buffer in new tab' })
-- M.nmap('<c-h>', '5zh', { desc = 'scroll left 5 characters' })
-- M.nmap('<c-l>', '5zh', { desc = 'scroll left 5 characters' })
M.vmap('J', [[:m '>+1<CR>gv=gv]], { desc = 'move visual block down' })
M.vmap('K', [[:m '<-2<CR>gv=gv]], { desc = 'move visual block up' })

M.vmap('<', '<gv', { desc = 'un-indent' })
M.vmap('>', '>gv', { desc = 'indent' })

M.imap("<C-L>", function()
	local node = vim.treesitter.get_node()
	if node ~= nil then
		local row, col = node:end_()
		pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
	end
end, { desc = "insjump" })
M.imap('<C-e>', function()
	if pumvisible() then h.feedkeys '<C-e>' else h.feedkeys '<esc>ea' end
end, { desc = "like 'e' but in insert" })
M.imap('<C-t>', '<esc>/[)}"\'\\]>]<CR>:nohlsearch<CR>a', { desc = "move outside next closing thing" })

M.tmap('<C-q>', h.t([[<C-\><C-n><C-W>w]]), { desc = 'cycle splits' })
-- M.tmap('<C-t>n', h.t([[<C-\><C-n>]]), { desc = 'normal mode' })

--lsp
local toggle_state = true
local function lsp_diag_toggle()
	local toggled = not toggle_state
	toggle_state = toggled
	-- vim.diagnostic.config({virtual_text = toggled, underline = toggled})
	vim.diagnostic.config({ virtual_text = toggled, underline = toggled })
end

M.nmap('<leader>uu', h.show_diagnostics, { desc = 'show diagnostic counts' })
M.nmap('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'prev diagnostic' })
M.nmap(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'next diagnostic' })
M.nmap('[e', function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = -1, float = true })
end, { desc = 'prev diagnostic error' })
M.nmap(']e', function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = 1, float = true })
end, { desc = 'next diagnostic error' })

set_group('n', '<leader>', '+leader')
set_group('n', '<leader>l', 'lsp')
M.nmap('<leader>ll', vim.diagnostic.open_float, { desc = 'show diagnostics' })
M.nmap('<leader>le', lsp_diag_toggle, { desc = 'toggle some virtual text' })
M.nmap('<leader>lq', function()
	vim.diagnostic.setqflist({ bufnr = 0, severity = vim.diagnostic.severity.ERROR, })
end, { desc = 'all errors in qf buffer' })
M.nmap('<leader>lQ', function()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, })
end, { desc = 'all errors in qf' })


-- plugin groups
set_group('n', '<leader>f', '+find')
set_group('n', '<leader>lm', '+llm')
set_group('n', '<leader>h', 'git hunk')
set_group('n', '<leader>g', 'git')
set_group('n', '<leader>w', 'Vimwiki')
-- nnn
set_group('n', '<leader>n', 'nnn file manager')

return M
