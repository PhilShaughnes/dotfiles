local h = require('helpers')
local M = {
	{ 'ojroques/nvim-osc52',             lazy = true },              -- probably can trigger this via keymaps
	{ 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' }, -- make_it_rain / game_of_life
	{ 'RRethy/nvim-align',               cmd = 'Align' },
	{ 'kana/vim-niceblock',              event = 'InsertEnter' },
	{ 'windwp/nvim-autopairs',           opts = {},                event = 'InsertEnter' },
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
