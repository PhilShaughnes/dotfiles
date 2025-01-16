local h = require('helpers')
local M = {
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			on_attach = function()
				local gs = require('gitsigns')
				h.map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = "reset hunk" })
				h.map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = "stage hunk" })
				h.nmap('<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
				h.nmap('<leader>hd', gs.diffthis, { desc = "diff against index" })
				h.nmap('<leader>hD', function() gs.diffthis('~1') end, { desc = "diff against last commit" })
				h.nmap('<leader>hn', function() gs.change_base('~1') end, { desc = "signs against last commit" })
				h.nmap('<leader>hm', function() gs.reset_base() end, { desc = "reset signs base" })
				h.nmap('<leader>hc', function() gs.blame_line { full = true } end, { desc = "show commit info" })
				h.nmap('<leader>hq', function() gs.setqflist() end, { desc = "hunks in qf list" })
				h.nmap('<leader>hS', function() gs.show('~1') end, { desc = "show file state in last commit" })
				h.nmap('<leader>hb', function() gs.toggle_current_line_blame() end, { desc = "toggle line blame" })
				h.oxmap('ih', ":<C-U>Gitsigns select_hunk<CR>", { desc = "select hunk" })
				h.nmap(']h', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { desc = "next hunk" })
				h.nmap('[h', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { desc = "prev hunk" })
			end
		},
		event = 'VeryLazy',
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua",    -- optional
		},
		opts = {
			integrations = {
				diffview = true,
				fzf_lua = true,
			}
		},
		cmd = "Neogit",
		init = function()
			h.nmap('<leader>gg', ':Neogit<CR>', { desc = "open git view" })
		end
	},
	{
		'ruifm/gitlinker.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { mappings = nil },
		lazy = true,
		init = function()
			local gl = function(mode, opts)
				return function() require "gitlinker".get_buf_range_url(mode, opts) end
			end
			h.nmap('<leader>gy', gl('n'), { desc = 'yank github link' })
			h.vmap('<leader>gy', gl('v'), { desc = 'yank github link' })
		end
	},
	{
		'sindrets/diffview.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
	},
}

return M
