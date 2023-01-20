local M = {}

M.border = {'╭','─','╮','│','╯','─','╰','│'}

function M.merge(a, b)
	return vim.tbl_extend('force', a, b)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.feedkeys(str)
  return vim.api.nvim_feedkeys(M.t(str), 'n', true)
end

function M.mapper(mode, rhs, lhs, opts, defaults)
	local options = {remap = false, silent = true}
	if defaults then options = defaults end
	if opts then options = vim.tbl_extend('force', defaults, opts) end
	vim.keymap.set(mode, rhs, lhs, options)
end

function M.map(mode, rhs, lhs, opts)
	local defaults = {silent = true}
	M.mapper(mode, rhs, lhs, opts, defaults)
end

function M.nmap(rhs, lhs, opts) M.map('n', rhs, lhs, opts) end
function M.tmap(rhs, lhs, opts) M.map('t', rhs, lhs, opts) end
function M.vmap(rhs, lhs, opts) M.map('v', rhs, lhs, opts) end
function M.imap(rhs, lhs, opts) M.map('i', rhs, lhs, opts) end
function M.oxmap(rhs, lhs, opts) M.map({'x', 'o'}, rhs, lhs, opts) end

function M.lazyload(plug)
	return function(func)
		if func then
			return function(args)
				require(plug)[func](args)
			end
		else
			return require(plug)
		end
	end
end

function M.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

_G.dump = M.dump

return M
