local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local enter = augroup('vimenter', { clear = true })
autocmd({ 'VimEnter' }, {
	pattern = '*',
	callback = function() vim.fn.setreg('p', '<++>') end,
	group = enter,
})

local term = augroup('term', { clear = true })
autocmd({ 'BufEnter', 'TermOpen' }, {
	pattern = 'term://*',
	command = 'startinsert',
	group = term
})
autocmd({ 'termOpen' }, {
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = 'no'
	end,
	group = term
})


local interface = augroup('interface', { clear = true })
autocmd({ 'textYankPost' }, {
	callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 }) end,
	group = interface
})
autocmd({ 'InsertEnter' }, {
	group = interface,
	callback = function() vim.o.hlsearch = false end
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = interface,
	callback = function()
		local cmd_type = vim.fn.getcmdtype()
		if cmd_type == '/' or cmd_type == '?' then vim.o.hlsearch = true end
	end,
})
-- keep split proportions when resizing terminal
autocmd({ 'VimResized' }, {
	group = interface,
	command = 'wincmd ='
})

local quickfix = augroup('quickfix', { clear = true })
autocmd({ "QuickFixCmdPost" }, {
	group = quickfix,
	pattern = "[^l]*",
	command = 'cwindow'
})
autocmd({ "QuickFixCmdPost" }, {
	group = quickfix,
	pattern = "l*",
	command = 'lwindow'
})

local saving = augroup('saving', { clear = true })
-- check if the file was updated somewhere else
autocmd({ 'WinEnter', 'BufWinEnter', 'FocusGained' }, {
	group = saving,
	command = 'checktime'
})
-- save marks and other info (?)
autocmd({ 'VimLeave' }, {
	group = saving,
	command = 'wshada!'
})

local ft = augroup('ft', { clear = true })
autocmd({ "BufEnter" }, {
	group = ft,
	pattern = "*.lua",
	callback = function()
		vim.opt_local.suffixesadd:prepend('.lua')
		vim.opt_local.suffixesadd:prepend('init.lua')
		vim.opt_local.path:prepend(vim.fn.stdpath('config') .. '/lua')
	end
})
