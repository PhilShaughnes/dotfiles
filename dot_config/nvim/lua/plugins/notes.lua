local h = require('helpers')
local M = {
	{
		'jbyuki/venn.nvim',
		cmd = { 'VBox' },
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
	-- {
	-- 	"gaoDean/autolist.nvim",
	-- 	ft = {
	-- 		"markdown",
	-- 		"text",
	-- 		"tex",
	-- 		"plaintex",
	-- 	},
	-- 	config = function()
	-- 		local autolist = require("autolist")
	-- 		autolist.setup()
	-- 		autolist.create_mapping_hook("i", "<CR>", autolist.new)
	-- 		autolist.create_mapping_hook("n", "o", autolist.new)
	-- 		autolist.create_mapping_hook("n", "O", autolist.new_before)
	-- 		autolist.create_mapping_hook("n", ">>", autolist.indent)
	-- 		autolist.create_mapping_hook("n", "<<", autolist.indent)
	-- 		autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
	-- 		autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
	-- 		-- vim.api.nvim_create_autocmd("TextChanged", {
	-- 		-- 	pattern = "*",
	-- 		-- 	callback = function()
	-- 		-- 		vim.cmd.normal({autolist.force_recalculate(nil, nil), bang = false})
	-- 		-- 	end
	-- 		-- })
	-- 	end,
	-- },
}
return M