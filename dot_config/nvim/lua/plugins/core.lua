local h = require("helpers")

local M = {
	{ "echasnovski/mini.surround", event = "VeryLazy", opts = {} },
	-- {
	-- 	'windwp/nvim-autopairs',
	-- 	opts = {},
	-- 	event = 'InsertEnter',
	-- },
	{
		"luukvbaal/nnn.nvim",
		cmd = "NnnPicker",
		config = function()
			require("nnn").setup({
				picker = {
					cmd = "nnn -o",
					style = {
						width = 0.5,
						height = 0.7,
					},
				},
			})
		end,
		init = function()
			h.nmap("<leader>nn", ":NnnPicker<CR>", { desc = "nnn window in root" })
			h.nmap("<leader>nm", ":NnnPicker %:p:h<CR>", { desc = "nnn window in dir of current file" })
			h.nmap("<leader>nr", ":NnnExplorer<CR>", { desc = "nnn sidebar in root" })
			h.nmap("<leader>nl", ":NnnExplorer %:p:h<CR>", { desc = "nnn sidebar in dir of current file" })
		end,
	},
	{ "folke/which-key.nvim",      lazy = true },
	{
		"Wansmer/treesj",
		cmd = "TSJToggle",
		dependencies = { "nvim-treesitter" },
		opts = { use_default_keymaps = false },
		init = function()
			h.nmap("<leader>v", ":TSJToggle<cr>", { desc = "toggle joins" })
		end,
	},
}

return M
