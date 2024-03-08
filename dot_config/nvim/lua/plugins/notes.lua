local h = require('helpers')
local M = {
	{
		'jbyuki/venn.nvim',
		cmd = { 'VBox' },
	},
	{
		'epwalsh/obsidian.nvim',
		version = "*",
		lazy = true,
		ft = "markdown",
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/Documents/notes"
				}
			},
			mappings = {
				["<leader>x"] = {
					action = function()
						require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true, desc = "toggle todo" }
				}
			},
		}
	},
	{
		'vimwiki/vimwiki',
		cmd = "VimwikiIndex",
		config = function()
			vim.g.vimwiki_list = {
				['path'] = '~/vimwiki',
				['syntax'] = 'default',
				['ext'] = '.wiki'
			}
		end,
		init = function()
			h.nmap("<leader>ww", "<cmd>VimwikiIndex<cr>", { desc = "open vimwiki" })
		end
	},
}
return M
