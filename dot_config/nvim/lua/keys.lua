local cmd = vim.cmd
-- assume which key is installed
-- maybe consider using https://github.com/mrjones2014/legendary.nvim
local M = {}
local h = require('helpers')

local haswk, wk = pcall(require, "which-key")
local haskm, km = pcall(require, "key-menu")
-- local haswk, wk = false, false
-- local haskm, km = false, false
if haswk then wk.setup({plugins = {spelling = {enabled = true}}}) end


-- HELPER FUNCTIONS
local function set_group(mode, keys, desc)
  if haswk then
   wk.register({[keys] = {name = desc}})
	elseif haskm then
		km.set(mode, keys, {desc = desc})
	else
		vim.notify_once('which-key and key-menu not available')
	end
end

function M.map(mode, rhs, lhs, opts)
	local defaults = {silent = true}
	h.mapper(mode, rhs, lhs, opts, defaults)
end

function M.nmap(rhs, lhs, opts) M.map('n', rhs, lhs, opts) end
function M.tmap(rhs, lhs, opts) M.map('t', rhs, lhs, opts) end
function M.vmap(rhs, lhs, opts) M.map('v', rhs, lhs, opts) end
function M.imap(rhs, lhs, opts) M.map('i', rhs, lhs, opts) end
function M.oxmap(rhs, lhs, opts) M.map({'x', 'o'}, rhs, lhs, opts) end

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


M.nmap('<C-k>',     ':cprev',  { desc = 'quickfix previous' })
M.nmap('<C-j>',     ':cnext',  { desc = 'quickfix next' })
M.nmap('<leader>k', ':lprev',   { desc = 'loclist previous' })
M.nmap('<leader>j', ':lnext',   { desc = 'loclist next' })
M.nmap('\\\\',      toggle_qf, { desc = 'quickfix toggle' })

M.nmap("<leader>,", function() M.line_end_toggle(',') end, { desc = "toggle , at end of line" })
M.nmap("<leader>;", function() M.line_end_toggle(';') end, { desc = "toggle : at end of line" })

M.nmap('<leader>:', ':lua ', { desc = 'command mode with lua', silent = false})
M.nmap('<leader>b', ':ls<CR>:b<space>', { desc = "show buffers", silent = false })
M.nmap('<leader> ', ':set hlsearch!<CR>', { desc = 'toggle search highlight' })
M.nmap('<leader>/', [[:'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/]],
  { desc = 'replace all word in paragraph', silent = false })
M.nmap('<leader>%', [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
	{ desc = 'replace all word in buffer', silent = false })

M.nmap('j', 'gj', { desc = 'down' })
M.nmap('k', 'gk', { desc = 'up' })
M.nmap('gV', '`[v`]', { desc = 'highlight last inserted text' })
-- M.nmap('H', '^', { desc = 'go to begining of line' })
M.nmap('gh', '^', { desc = 'go to begining of line' })
-- M.nmap('L', '$', { desc = 'go to end of line' })
M.nmap('gl', '$', { desc = 'go to end of line' })
M.map({'n', 'v'}, 'Q', '@q', { desc = 'run default (q) macro' })
M.nmap('R', '"0p', { desc = 'Paste contents of 0 register' })
M.vmap('R', '"ddp', { desc = 'Replace with contents of * register' })
M.nmap('Y', 'y$', { desc = 'yank to the end of the line' })
M.nmap('[<space>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', {desc = "add line above"})
M.nmap(']<space>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', {desc = "add line below"})

M.nmap("'", '`', { desc = 'go to mark location (set with letter m)' })
M.nmap('<bs>', ':b#<CR>', { desc = 'switch to last buffer' })
M.nmap('gn', ':bn<CR>', {desc = 'next buffer on list'})
M.nmap('gp', ':bp<CR>', {desc = 'previous buffer on list'})
M.nmap('gm', ':b#<CR>', {desc = 'last buffer'})

M.nmap('z/', ':set cursorcolumn! <bar> set cursorline!<CR>', { desc = 'toggle cursor line and column highlight' })
M.nmap('z.', ':set relativenumber!<bar> set list!<CR>', { desc = 'toggle relative number and tabs' })
M.nmap('z,', ':set hlsearch!<CR>', { desc = 'toggle search highlight' })
M.nmap('<C-j>', ':cn<CR>', { desc = 'down in quickfix window' })
M.nmap('<C-k>', ':cp<CR>', { desc = 'up in quickfix window' })
M.nmap('<C-q>', '<C-w>w', { desc = 'cycle splits' })
M.nmap('<C-w>m', ':tab split<CR>', { desc = 'open current buffer in new tab' })
-- M.nmap('<c-h>', '5zh', { desc = 'scroll left 5 characters' })
-- M.nmap('<c-l>', '5zh', { desc = 'scroll left 5 characters' })
M.vmap('J', [[:m '>+1<CR>gv=gv]], { desc = 'move visual block down' })
M.vmap('K', [[:m '<-2<CR>gv=gv]], { desc = 'move visual block up' })
M.vmap('<', '<gv', { desc = 'un-indent' })
M.vmap('>', '>gv', { desc = 'indent' })

M.imap('<C-e>', '<esc>ea', { desc = "like 'e' but in insert" })
M.imap('<C-t>', '<esc>/[)}"\'\\]>]<CR>:nohlsearch<CR>a', { desc = "move outside next closing thing" })


M.tmap('<C-q>', h.t([[<C-\><C-n><C-W>w]]), { desc = 'cycle splits' })
M.tmap('<C-t>n', h.t([[<C-\><C-n>]]), { desc = 'normal mode' })

--lsp
local toggle_state = true
local function lsp_diag_toggle()
	local toggled = not toggle_state
	toggle_state = toggled
	-- vim.diagnostic.config({virtual_text = toggled, underline = toggled})
	vim.diagnostic.config({virtual_text = toggled, underline = toggled})
end

M.nmap('[d', vim.diagnostic.goto_prev, { desc = 'prev diagnostic' })
M.nmap(']d', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
M.nmap('K',  vim.lsp.buf.hover,        { desc = 'documentation' })
M.nmap('gd', vim.lsp.buf.definition,   { desc = 'show definition' })
M.nmap('gr', vim.lsp.buf.references,   { desc = 'references' })

set_group('n', '<leader>', '+leader')
set_group('n', '<leader>l', 'lsp')
M.nmap('<leader>ll',  vim.diagnostic.open_float, { desc = 'show diagnostics' })
M.nmap('<leader>le',  lsp_diag_toggle, { desc = 'toggle some virtual text' })
M.nmap('<leader>lq',  vim.diagnostic.setqflist, { desc = 'all diagnostics in qf' })
M.nmap('<leader>lr',  vim.lsp.buf.references, { desc = 'references' })
M.nmap('<leader>ld',  vim.lsp.buf.definition, { desc = 'show definition' })
M.nmap('<leader>lD',  vim.lsp.buf.declaration, { desc = 'show declaration' })
M.nmap('<leader>li',  vim.lsp.buf.implementation, { desc = 'show declaration' })
M.nmap('<leader>lf',  vim.lsp.buf.format, { desc = 'format buffer' });
M.nmap('<leader>lk',  vim.lsp.buf.hover, { desc = 'documentation' })
M.nmap('<leader>lp',  vim.diagnostic.goto_prev, { desc = 'prev diagnostic' })
M.nmap('<leader>ln',  vim.diagnostic.goto_next, { desc = 'next diagnostic' })
M.nmap('<leader>la',  ':CodeActionMenu<CR>', { desc = 'code actions menu' })

-- nnn
set_group('n', '<leader>n', 'nnn file manager')
M.nmap('<leader>nn', ':NnnPicker<CR>', { desc = "nnn window in root" })
M.nmap('<leader>nm', ":NnnPicker %:p:h<CR>", { desc = "nnn window in dir of current file" })
M.nmap('<leader>nr',  ":NnnExplorer<CR>", { desc = "nnn sidebar in root" })
M.nmap('<leader>nl',  ":NnnExplorer %:p:h<CR>", { desc = "nnn sidebar in dir of current file" })

-- fzf
M.fzf = function() return require('fzf-lua') end

set_group('n', '<leader>f', '+find')
M.nmap('<leader>ff', function()
	M.fzf().files({ fd_opts = "--color=never --type f --follow --exclude .git" }) end,
	{ desc = 'find files' })
M.nmap('<leader>fa', function()
M.fzf().files({fd_opts = "--color=never --type f --follow --no-ignore"}) end,
	{ desc = 'find all files' })
M.nmap('<leader>fh', function() M.fzf().files() end, { desc = 'find hidden files' })
M.nmap('<leader>fb', function() M.fzf().buffers() end, { desc = 'find buffers' })
M.nmap('<leader>fc', function() M.fzf().git_commits() end, { desc = 'find commits' })
M.nmap('<leader>fg', function() M.fzf().grep() end, { desc = 'grep text' })
M.nmap('<leader>ft', function() M.fzf().grep_project() end, { desc = 'find text project' })
M.nmap('<leader>fl', function() M.fzf().live_grep_native() end, { desc = 'find text live' })
M.nmap('<leader>fw', function() M.fzf().grep_cword() end, { desc = 'find word under cursor' })
M.nmap('<leader>fW', function() M.fzf().grep_cWORD() end, { desc = 'find WORD under cursor' })
M.nmap('<leader>fv', function() M.fzf().colorschemes() end, { desc = 'find colorscheme' })
M.nmap('<leader>fh', function() M.fzf().highlights() end, { desc = 'find highlight group' })

M.vmap('<leader>ff', function() M.fzf().grep_visual() end, { desc = 'grep visual selection' })
-- markdown
M.nmap('<leader>mm', function() M.fzf().files({cwd = '~/notes/wiki'}) end, {desc = 'find notes'})

-- gitsigns
set_group('n', '<leader>h', 'git hunk')
local gs = require('gitsigns')
M.map({'n', 'v'}, '<leader>hr', gs.reset_hunk, { desc = "reset hunk" })
M.map({'n', 'v'}, '<leader>hs', gs.stage_hunk, { desc = "stage hunk" })
M.nmap('<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
M.nmap('<leader>hd', gs.diffthis, { desc = "diffthis" })
M.nmap('<leader>hD', function() gs.diffthis('~') end, { desc = "diffthis" })
M.nmap('<leader>hc', function() gs.blame_line{full=true} end, { desc = "show commit info" })
M.nmap('<leader>hb', function() gs.toggle_current_line_blame() end, { desc = "toggle line blame" })
M.oxmap('ih', ":<C-U>Gitsigns select_hunk<CR>", { desc = "select hunk" })

M.nmap(']c', function()
		if vim.wo.diff then return ']c' end
		vim.schedule(function() gs.next_hunk() end)
		return '<Ignore>'
	end, { desc = "next hunk" })
M.nmap('[c', function()
		if vim.wo.diff then return '[c' end
		vim.schedule(function() gs.prev_hunk() end)
		return '<Ignore>'
	end, { desc = "prev hunk" })

set_group('n', '<leader>g', 'git')
-- M.nmap('<leader>gg', ':Git<CR>', { desc = "open git view" })

-- leap
-- M.map({'n','v','o','x'}, '<leader>s', function()
--   require('leap').leap { target_windows = { vim.fn.win_getid() } }
-- end, { desc = "leap"})

-- plugin groups
set_group('n', '<leader>s', 'Sessions')
set_group('n', '<leader>w', 'Vimwiki')
return M
