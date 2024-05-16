local h = require('helpers')
local M = {
	{
		'dcampos/nvim-snippy',
		keys = {
			{
				'<c-t>',
				function() require('snippy').complete() end,
				desc = 'snippet completion',
				mode = 'i',
			}
		},
		opts = {
			mappings = {
				is = {
					['<c-j>'] = 'expand_or_advance',
					['<c-k>'] = 'previous',
				},
				nx = {
					['<leader>x'] = 'cut_text',
				},
			},
		}
	},
	{ 'echasnovski/mini.surround', event = "VeryLazy", opts = {} },
	-- { 'echasnovski/mini.surround', event = "BufReadPost", opts = {} },
	{
		'ibhagwan/fzf-lua',
		lazy = true,
		opts = {
			keymap = {
				builtin = {
					["<C-f>"]    = "toggle-fullscreen",
					-- Only valid with the 'builtin' previewer
					["<C-w>"]    = "toggle-preview-wrap",
					["<C-p>"]    = "toggle-preview",
					-- Rotate preview clockwise/counter-clockwise
					["<C-l>"]    = "toggle-preview-ccw",
					["<C-h>"]    = "toggle-preview-cw",
					["<S-down>"] = "preview-page-down",
					["<S-up>"]   = "preview-page-up",
					["<S-left>"] = "preview-page-reset",
				}
			}
		}
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
		end,
		init = function()
			h.nmap('<leader>nn', ':NnnPicker<CR>', { desc = "nnn window in root" })
			h.nmap('<leader>nm', ":NnnPicker %:p:h<CR>", { desc = "nnn window in dir of current file" })
			h.nmap('<leader>nr', ":NnnExplorer<CR>", { desc = "nnn sidebar in root" })
			h.nmap('<leader>nl', ":NnnExplorer %:p:h<CR>", { desc = "nnn sidebar in dir of current file" })
		end
	},
	{ 'folke/which-key.nvim',      lazy = true },
}

return M
