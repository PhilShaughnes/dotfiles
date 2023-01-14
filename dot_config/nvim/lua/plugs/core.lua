local M = {
	{'numToStr/Comment.nvim', opts = {}},
	{'kevinhwang91/nvim-bqf', ft = 'qf'},
	-- {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({}) end},
	{'windwp/nvim-autopairs', opts = {}, event = 'InsertEnter'},
	{'ojroques/nvim-osc52', lazy = true}, -- probably can trigger this via keymaps
	{
		'kylechui/nvim-surround',
		opts = {
			move_cursor = false,
			keymaps = {
        normal = "sa",
        delete = "sd",
        change = "sr",
        visual = "sa",
        visual_line = "Sa",
			},
		}
	},
	{'Darazaki/indent-o-matic', opts = {}, event = 'VeryLazy'},
	-- {'nvim-lua/plenary.nvim', lazy = true},
	{'lewis6991/gitsigns.nvim', opts = {}, event = 'VeryLazy'},
	{
		'ibhagwan/fzf-lua',
		lazy = true,
		opts = {
			keymap = { builtin = {
			["<C-f>"]        = "toggle-fullscreen",
			-- Only valid with the 'builtin' previewer
			["<C-w>"]        = "toggle-preview-wrap",
			["<C-p>"]        = "toggle-preview",
			-- Rotate preview clockwise/counter-clockwise
			["<C-l>"]        = "toggle-preview-ccw",
			["<C-h>"]        = "toggle-preview-cw",
			["<S-down>"]     = "preview-page-down",
			["<S-up>"]       = "preview-page-up",
			["<S-left>"]     = "preview-page-reset",
		}}}
	},
	{
		'luukvbaal/nnn.nvim',
		cmd = 'NnnPicker',
		config = function()
			require('nnn').setup({
				picker = {
					cmd = 'nnn -o',
					style = {
						width = 0.5,
						height = 0.7,
					}
				},
				explorer = { cmd = "nnn -o" },
				replace_netrw = 'picker',
			})
		end
	},
	{ 'RRethy/nvim-align', cmd = 'Align' },
	{ 'folke/which-key.nvim', lazy = true },
	{ 'sindrets/diffview.nvim', cmd = {'DiffViewFileHistory', 'DiffviewOpen'} },
	{ 'tpope/vim-fugitive', cmd = 'Git' },
	{ 'kana/vim-niceblock', event = 'VeryLazy' },
	{ 'ggandor/leap.nvim', lazy = true },
}

return M
