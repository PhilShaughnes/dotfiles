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

function M.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
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
