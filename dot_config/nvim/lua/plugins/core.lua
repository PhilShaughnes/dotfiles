local h = require('helpers')
local M = {
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
			local ft = require('Comment.ft')
			ft.yaml = '#%s'
			ft({ 'toml', 'graphql', 'hurl' }, '#%s')
		end
	},
	{ 'kevinhwang91/nvim-bqf',   ft = 'qf' },
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
	{ 'Darazaki/indent-o-matic', opts = {} },
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
				h.nmap(']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { desc = "next hunk" })
				h.nmap('[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { desc = "prev hunk" })
			end
		},
		event = 'VeryLazy',
	},
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
	{ 'folke/which-key.nvim', lazy = true },
	{
		'echasnovski/mini.clue',
		lazy = true,
		version = false,
		config = function()
			local mclue = require('mini.clue')
			mclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = 'n', keys = '<Leader>' },
					{ mode = 'n', keys = '[' },
					{ mode = 'n', keys = ']' },
					{ mode = 'x', keys = '<Leader>' },

					-- Built-in completion
					{ mode = 'i', keys = '<C-x>' },
					--
					-- `g` key
					{ mode = 'n', keys = 'g' },
					{ mode = 'x', keys = 'g' },

					-- Marks
					{ mode = 'n', keys = "'" },
					{ mode = 'n', keys = '`' },
					{ mode = 'x', keys = "'" },
					{ mode = 'x', keys = '`' },

					-- Registers
					{ mode = 'n', keys = '"' },
					{ mode = 'x', keys = '"' },
					{ mode = 'i', keys = '<C-r>' },
					{ mode = 'c', keys = '<C-r>' },

					-- Window commands
					{ mode = 'n', keys = '<C-w>' },

					-- `z` key
					{ mode = 'n', keys = 'z' },
					{ mode = 'x', keys = 'z' },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					{ mode = 'n', keys = '<Leader>l', desc = '+LSP' },
					{ mode = 'n', keys = '<leader>h', desc = 'git hunk' },
					{ mode = 'n', keys = '<leader>g', desc = 'git' },
					{ mode = 'n', keys = '<leader>w', desc = 'Vimwiki' },
					{ mode = 'n', keys = '<leader>f', desc = 'find' },
					{ mode = 'n', keys = '<leader>u', desc = 'ui' },
					{ mode = 'n', keys = '<leader>n', desc = 'nnn file manager' },
					mclue.gen_clues.builtin_completion(),
					mclue.gen_clues.g(),
					mclue.gen_clues.marks(),
					mclue.gen_clues.registers({ show_contents = true }),
					mclue.gen_clues.windows(),
					mclue.gen_clues.z(),
				},
			})
		end,
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua",    -- optional
		},
		config = true,
		cmd = "Neogit",
		init = function()
			h.nmap('<leader>gg', ':Neogit<CR>', { desc = "open git view" })
		end
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
}

return M
