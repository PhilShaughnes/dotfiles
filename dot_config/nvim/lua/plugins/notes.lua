local h = require('helpers')
local M = {
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
	{
		'epwalsh/obsidian.nvim',
		version = "*",
		lazy = true,
		-- ft = "markdown",
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
				},
			},
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				-- local suffix = ""
				-- if title ~= nil then
				-- 	-- If title is given, transform it into valid file name.
				-- 	suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				-- else
				-- 	-- If title is nil, just add 4 random uppercase letters to the suffix.
				-- 	for _ = 1, 4 do
				-- 		suffix = suffix .. string.char(math.random(65, 90))
				-- 	end
				-- end
				-- return tostring(os.time()) .. "-" .. suffix
				if title ~= nil then
					return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					return string.char(math.random(65, 90))
				end
			end,
			wiki_link_func = function(opts)
				return require("obsidian.util").wiki_link_path_prefix(opts)
			end
		}
	},
	{
		'vimwiki/vimwiki',
		cmd = "VimwikiIndex",
		config = function()
			vim.g.vimwiki_list = {
				['path'] = '~/Documents/vimwiki',
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
