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
	{ 'nvimdev/epo.nvim', event = "InsertEnter", config = true, },
	-- { 'echasnovski/mini.completion', event = "insertEnter", config = true, },
	-- {
	-- 	'dcampos/nvim-snippy',
	-- 	keys = {
	-- 		{
	-- 			'<c-t>',
	-- 			function() require('snippy').complete() end,
	-- 			desc = 'snippet completion',
	-- 			mode = 'i',
	-- 		}
	-- 	},
	-- 	opts = {
	-- 		mappings = {
	-- 			is = {
	-- 				['<c-j>'] = 'expand_or_advance',
	-- 				['<c-k>'] = 'previous',
	-- 			},
	-- 			nx = {
	-- 				['<leader>x'] = 'cut_text',
	-- 			},
	-- 		},
	-- 	}
	-- },
}

return M
