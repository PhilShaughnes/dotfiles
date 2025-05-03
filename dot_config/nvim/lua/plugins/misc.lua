local M = {
	-- { 'ojroques/nvim-osc52',     lazy = true }, -- probably can trigger this via keymaps
	-- { 'RRethy/nvim-align', cmd = 'Align' },
	-- { 'kevinhwang91/nvim-bqf',   ft = 'qf' },
	-- { 'Darazaki/indent-o-matic', cmd = "IndentOMatic", opts = {} },
	-- { 'kana/vim-niceblock',      event = 'InsertEnter' },
	{
		"jbyuki/venn.nvim",
		cmd = { "VBox" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		ft = { "markdown", "codecompanion" },
		opt = {},
	},
	{
		"nfrid/markdown-togglecheck",
		dependencies = { "nfrid/treesitter-utils" },
		ft = { "markdown" },
		keys = {
			{
				"<leader>x",
				function()
					require("markdown-togglecheck").toggle()
				end,
				desc = "Toggle checkmark",
				mode = { "n", "x" },
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		opts = {},
		lazy = true,
		keys = {
			{
				"<leader>uc",
				function()
					local c = require("colorizer")
					if c.is_buffer_attached(0) then
						c.detach_from_buffer(0)
						package.loaded["colorizer"] = nil
					else
						package.loaded["colorizer"] = nil
						require("colorizer").attach_to_buffer(0)
					end
				end,
				desc = "toggle colorizer",
			},
		},
	},
	-- { 'nvim-tree/nvim-web-devicons', lazy = true },
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- },
	-- { "rebelot/kanagawa.nvim" },
	-- { "EdenEast/nightfox.nvim" },
	-- {
	-- 	"zenbones-theme/zenbones.nvim",
	-- 	dependencies = "rktjmp/lush.nvim",
	-- },
}

vim.cmd(
	[[set wildignore+=blue.vim,darkblue.vim,delek.vim,desert.vim,elflord.vim,evening.vim,industry.vim,koehler.vim,lunaperche.vim,morning.vim,murphy.vim,pablo.vim,peachpuff.vim,quiet.vim,retrobox.vim,ron.vim,shine.vim,slate.vim,sorbet.vim,torte.vim,wildcharm.vim,zaibatsu.vim,zellner.vim]]
)
return M
