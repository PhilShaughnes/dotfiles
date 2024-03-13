local M = {}

M.border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

function M.merge(a, b)
	return vim.tbl_extend('force', a, b)
end

function M.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.feedkeys(str)
	return vim.api.nvim_feedkeys(M.t(str), 'n', true)
end

function M.mapper(mode, defaults)
	return function(rhs, lhs, opts)
		local options = { remap = false, silent = true }
		if defaults then options = defaults end
		if opts then options = vim.tbl_extend('force', options, opts) end
		vim.keymap.set(mode, rhs, lhs, options)
	end
end

function M.map(mode, rhs, lhs, opts)
	local defaults = { silent = true }
	local options = defaults
	if opts then options = vim.tbl_extend('force', defaults, opts) end
	vim.keymap.set(mode, rhs, lhs, options)
end

M.nmap = M.mapper('n')
M.tmap = M.mapper('t')
M.vmap = M.mapper('v')
M.xmap = M.mapper('x')
M.imap = M.mapper('i')
M.oxmap = M.mapper({ 'x', 'o' })

function M.lazyload(plug)
	return function(func, args)
		if func then
			return function()
				vim.notify(plug, func, args)
				require(plug)[func](args)
			end
		else
			return require(plug)
		end
	end
end

function M.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end

function M.trim_ws()
	local saved = vim.fn.winsaveview()
	-- vim.fn.keeppatterns([[%s/\s\+$//e]])
	vim.cmd([[keeppatterns %s/\s\+$//e]])
	vim.fn.winrestview(saved)
end

_G.dump = M.dump
_G.trim_ws = M.trim_ws

local lineLength = function(lnum)
	local tab_hex_code = 9

	-- TODO: tabsize might be different than shiftwidth
	local expandtab    = vim.api.nvim_buf_get_option(0, "expandtab")
	local tabsize      = vim.api.nvim_buf_get_option(0, "shiftwidth")
	local line         = vim.fn.getline(lnum)
	local length       = #line

	if expandtab then
		return length
	end

	-- count tabs used as indentation
	for i = 1, #line do
		if line:byte(i) ~= tab_hex_code then
			break
		end
		length = length + tabsize - 1
	end

	return length
end

local move = function(key)
	-- NOTE: use norm command because nvim_win_set_cursor doesnt support virtual edit

	local row, col = vim.fn.line('.'), vim.fn.virtcol('.')

	local first_lnum = vim.fn.line('0')
	local last_lnum = vim.fn.line('$')

	local diff = key == 'k' and -1 or 1
	local lnum = row + diff
	local cnt = -1

	while lnum >= first_lnum and lnum <= last_lnum + 1 do
		cnt = cnt + 1
		if lineLength(lnum) < col then break end
		lnum = lnum + diff
	end

	if cnt ~= 0 then
		vim.cmd("norm " .. cnt .. key)
		return
	end

	while lnum >= first_lnum and lnum <= last_lnum + 1 do
		cnt = cnt + 1
		if lineLength(lnum) >= col then break end
		lnum = lnum + diff
	end

	vim.cmd("norm " .. cnt .. key)
end

function M.go_up() move('k') end

function M.go_down() move('j') end

return M
