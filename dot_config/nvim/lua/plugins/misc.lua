local h = require('helpers')
local get_closing_for_line = function(line)
	local i = -1
	local clo = ''

	while true do
		i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
		if i == nil then break end
		local ch = string.sub(line, i, i)
		local st = string.sub(clo, 1, 1)

		if ch == '{' then
			clo = '}' .. clo
		elseif ch == '}' then
			if st ~= '}' then return '' end
			clo = string.sub(clo, 2)
		elseif ch == '(' then
			clo = ')' .. clo
		elseif ch == ')' then
			if st ~= ')' then return '' end
			clo = string.sub(clo, 2)
		elseif ch == '[' then
			clo = ']' .. clo
		elseif ch == ']' then
			if st ~= ']' then return '' end
			clo = string.sub(clo, 2)
		end
	end

	return clo
end

local M = {
	{ 'ojroques/nvim-osc52',             lazy = true },              -- probably can trigger this via keymaps
	{ 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' }, -- make_it_rain / game_of_life
	{ 'RRethy/nvim-align',               cmd = 'Align' },
	{ 'kana/vim-niceblock',              event = 'InsertEnter' },
	{
		'windwp/nvim-autopairs',
		opts = {},
		config = function()
			local autopairs = require('nvim-autopairs')
			local Rule = require('nvim-autopairs.rule')
			autopairs.setup({})
			autopairs.remove_rule('(')
			autopairs.remove_rule('{')
			autopairs.remove_rule('[')

			autopairs.add_rule(Rule("[%(%{%[]", "")
				:use_regex(true)
				:replace_endpair(function(opts)
					return get_closing_for_line(opts.line)
				end)
				:end_wise(function(opts)
					-- Do not endwise if there is no closing
					return get_closing_for_line(opts.line) ~= ""
				end))
		end,
		event = 'InsertEnter',
	},
	{
		'abecodes/tabout.nvim',
		config = true,
		event = 'InsertEnter',
	},
	{
		'Wansmer/treesj',
		cmd = 'TSJToggle',
		dependencies = { 'nvim-treesitter' },
		opts = { use_default_keymaps = false },
		init = function()
			h.nmap('<leader>v', ':TSJToggle<cr>', { desc = 'toggle joins' })
		end,
	},
	{
		'sindrets/diffview.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
	},
}

return M
