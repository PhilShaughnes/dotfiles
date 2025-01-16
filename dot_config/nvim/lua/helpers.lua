local M = {}
-- TODO: diagnostics in line or something (e.g. troublesum)
-- TODO: indentomatic - easy swap to set spaces/tabs
-- TODO: spit a list on a single linto to multiple

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

function M.merge(a, b)
	return vim.tbl_extend("force", a, b)
end

function M.t(str)
	return vim.api.nvim_replace_termcodes(str, true, false, true)
end

function M.feedkeys(str)
	return vim.api.nvim_feedkeys(M.t(str), "n", true)
end

function M.mapper(mode, defaults)
	return function(rhs, lhs, opts)
		local options = { remap = false, silent = true }
		if defaults then
			options = defaults
		end
		if opts then
			options = vim.tbl_extend("force", options, opts)
		end
		vim.keymap.set(mode, rhs, lhs, options)
	end
end

function M.map(mode, rhs, lhs, opts)
	local defaults = { silent = true }
	local options = defaults
	if opts then
		options = vim.tbl_extend("force", defaults, opts)
	end
	vim.keymap.set(mode, rhs, lhs, options)
end

M.nmap = M.mapper("n")
M.tmap = M.mapper("t")
M.vmap = M.mapper("v")
M.xmap = M.mapper("x")
M.imap = M.mapper("i")
M.oxmap = M.mapper({ "x", "o" })

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

function M.go_indent_start()
	local current_pos = vim.api.nvim_win_get_cursor(0)
	local current_line = current_pos[1]
	local current_column = current_pos[2]
	local current_indent = vim.fn.indent(current_line)

	for i = current_line, 1, -1 do
		local line_content = vim.fn.getline(i)
		local line_indent = vim.fn.indent(i)

		-- If the indent is less than the current indent and the line is not empty
		if line_indent < current_indent and line_content:match("%S") then
			vim.api.nvim_win_set_cursor(0, { i + 1, current_column })
			return
		end
	end
	vim.api.nvim_win_set_cursor(0, { 1, current_column }) -- Jump to the first line
end

function M.go_indent_end()
	local current_pos = vim.api.nvim_win_get_cursor(0)
	local current_line = current_pos[1]
	local current_column = current_pos[2]
	local current_indent = vim.fn.indent(current_line)
	local last_line = vim.fn.line("$")

	for i = current_line, last_line do
		local line_content = vim.fn.getline(i)
		local line_indent = vim.fn.indent(i)

		-- If the indent is less than the current indent and the line is not empty
		if line_indent < current_indent and line_content:match("%S") then
			vim.api.nvim_win_set_cursor(0, { i - 1, current_column })
			return
		end
	end
	vim.api.nvim_win_set_cursor(0, { last_line, current_column }) -- Jump to the last line
end

function M.show_diagnostics()
	-- local severity_format = { '', '', '', '󰌵' }
	local fmt = { "x", "!", "i", "?" }
	local hl = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
	local counts = { 0, 0, 0, 0 }
	for _, d in pairs(vim.diagnostic.get(0)) do
		counts[d.severity] = counts[d.severity] + 1
	end

	local output = { { vim.fn.expand("%:p:.") .. " | " } }
	for i = 1, 4 do
		if counts[i] > 0 then
			table.insert(output, { counts[i] .. fmt[i] .. " ", hl[i] })
		end
	end
	table.insert(output, { vim.b.gitsigns_status })

	vim.api.nvim_echo(output, false, {})
end

return M
