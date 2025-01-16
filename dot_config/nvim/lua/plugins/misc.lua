local h = require('helpers')

local M = {
	-- { 'ojroques/nvim-osc52',     lazy = true }, -- probably can trigger this via keymaps
	-- { 'RRethy/nvim-align', cmd = 'Align' },
	-- { 'kevinhwang91/nvim-bqf',   ft = 'qf' },
	-- { 'Darazaki/indent-o-matic', cmd = "IndentOMatic", opts = {} },
	-- { 'kana/vim-niceblock',      event = 'InsertEnter' },
	{
		'jbyuki/venn.nvim',
		cmd = { 'VBox' },
	},
	{
		'nfrid/markdown-togglecheck',
		dependencies = { 'nfrid/treesitter-utils' },
		ft = { 'markdown' },
		keys = {
			{
				"<leader>x",
				function() require('markdown-togglecheck').toggle() end,
				desc = "Toggle checkmark",
				mode = { 'n', 'x' }
			},
		},
	},
}

return M
