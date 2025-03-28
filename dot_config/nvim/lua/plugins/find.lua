local h = require('helpers')
local USER = vim.fn.expand("$HOME")

local fzf_gitshow = function(opts)
	local fzf_lua = require 'fzf-lua'
	opts = opts or {}
	opts.prompt = "git> "
	opts.actions = {
		['default'] = function(selected)
			vim.cmd("Gitsigns show " .. selected[1]:match("(%w+)(.+)"))
		end
	}
	fzf_lua.fzf_exec([[git query "((draft() | branches() | @) % main()) | branches() | @"]], opts)
end

local fzfKeymaps = function()
	local fzf = function() return require('fzf-lua') end

	h.nmap('<leader>ff', function()
			fzf().files({
				fd_opts = "--color=never --type f --follow --exclude .git",
				-- actions = { ["ctrl-l"] = require 'fzf-lua.actions'.arg_add, },
			})
		end,
		{ desc = 'find files' })

	h.nmap('<leader>f;', function()
			fzf().files({
				fd_opts = "--color=never --type f --follow --no-ignore",
				-- actions = { ["ctrl-l"] = require 'fzf-lua.actions'.arg_add, },
			})
		end,
		{ desc = 'find all files' })

	h.nmap('<leader>fa', function() fzf().args() end, { desc = 'find arglist' })
	h.nmap(',f', function() fzf().args() end, { desc = 'find arglist' })
	h.nmap('<leader>fh', function() fzf().files({}) end, { desc = 'find hidden files' })
	h.nmap('<leader>fb', function() fzf().buffers() end, { desc = 'find buffers' })
	h.nmap('<leader>fc', function() fzf().git_commits() end, { desc = 'find commits' })
	h.nmap('<leader>fs', function() fzf_gitshow() end, { desc = 'show commits' })
	h.nmap('<leader>fd', function() fzf().diagnostics_document() end, { desc = 'find diagnostics' })
	h.nmap('<leader>fq', function() fzf().quickfix() end, { desc = 'find in quickfix' })
	h.nmap('<leader>fg', function() fzf().grep() end, { desc = 'grep text' })
	h.nmap('<leader>ft', function() fzf().grep_project() end, { desc = 'find text project' })
	h.nmap('<leader>fl', function() fzf().live_grep_native() end, { desc = 'find text live' })
	h.nmap('<leader>fw', function() fzf().grep_cword() end, { desc = 'find word under cursor' })
	h.nmap('<leader>fW', function() fzf().grep_cWORD() end, { desc = 'find WORD under cursor' })
	h.nmap('<leader>fv', function() fzf().colorschemes() end, { desc = 'find colorscheme' })
	-- h.nmap('<leader>fh', function() fzf().highlights() end, { desc = 'find highlight group' })
	h.nmap('<leader>fk', function() fzf().help_tags() end, { desc = 'find help' })

	h.vmap('<leader>ff', function() fzf().grep_visual() end, { desc = 'grep visual selection' })
	-- markdown
	h.nmap('<leader>mm', function() fzf().files({ cwd = USER .. '/notes/wiki' }) end, { desc = 'find notes' })
end

local M = {
	'ibhagwan/fzf-lua',
	lazy = true,
	init = fzfKeymaps,
	-- opts = {
	-- 	-- keymap = {
	-- 	-- 	builtin = {
	-- 	-- 		["<C-f>"]    = "toggle-fullscreen",
	-- 	-- 		-- Only valid with the 'builtin' previewer
	-- 	-- 		["<C-w>"]    = "toggle-preview-wrap",
	-- 	-- 		["<C-p>"]    = "toggle-preview",
	-- 	-- 		-- Rotate preview clockwise/counter-clockwise
	-- 	-- 		["<C-l>"]    = "toggle-preview-ccw",
	-- 	-- 		["<C-h>"]    = "toggle-preview-cw",
	-- 	-- 		["<S-down>"] = "preview-page-down",
	-- 	-- 		["<S-up>"]   = "preview-page-up",
	-- 	-- 		["<S-left>"] = "preview-page-reset",
	-- 	-- 	}
	-- 	-- }
	-- }
}

return M
