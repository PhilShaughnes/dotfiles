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

return M
