local h = require('helpers')

local M = {
	{ 'ojroques/nvim-osc52',     lazy = true }, -- probably can trigger this via keymaps
	{ 'RRethy/nvim-align',       cmd = 'Align' },
	{ 'kevinhwang91/nvim-bqf',   ft = 'qf' },
	{ 'Darazaki/indent-o-matic', cmd = "IndentOMatic", opts = {} },
	{ 'kana/vim-niceblock',      event = 'InsertEnter' },
	{
		'windwp/nvim-autopairs',
		opts = {},
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
		"otavioschwanck/arrow.nvim",
		lazy = true,
		keys = {
			{ ";", function() require("arrow.ui").openMenu() end, desc = "arrow" },
		},
		opts = {
			show_icons = true,
			leader_key = ';' -- Recommended to be a single key
		}
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
}

return M
