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
	{
		'saccarosium/neomarks',
		config = true,
		keys = {
			{
				'<leader>jj',
				function() require('neomarks').menu_toggle() end,
				desc = 'neomarks menu',
				mode = 'n'
			},
			{
				'<leader>ja',
				function() require('neomarks').mark_file() end,
				desc = 'neomark file',
				mode = 'n'
			},
			{
				'<leader>jw',
				function() require('neomarks').jump_to(1) end,
				desc = 'neomark goto 1',
				mode = 'n'
			},
			{
				'<leader>je',
				function() require('neomarks').jump_to(2) end,
				desc = 'neomark goto 2',
				mode = 'n'
			},
			{
				'<leader>jr',
				function() require('neomarks').jump_to(3) end,
				desc = 'neomark goto 3',
				mode = 'n'
			},
			{
				'<leader>jt',
				function() require('neomarks').jump_to(4) end,
				desc = 'neomark goto 4',
				mode = 'n'
			},
		},
	},
	-- {
	-- 	'jinh0/eyeliner.nvim',
	-- 	opt = {
	-- 		highlight_on_key = true,
	-- 	},
	-- 	keys = { 'f', 't' }
	-- },
}

return M
