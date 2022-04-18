vim.filetype.add({
	extension = {
		sh = "bash",
		log = "log",
		sql = "sql",
		-- tmpl = function(path, _bufnr)
		-- 	if (path:match('tmux.conf.tmpl')) then return "tmux"
		-- 	elseif (path:match('gitconfig.tmpl')) then return "gitconfig"
		-- 	else return "template"
		-- 	end
		-- end,
	},
	filename = {
		-- ['dot_tmux.conf.tmpl'] = "tmux",
		-- ['dot_gitconfig.tmpl'] = "gitconfig",
	},
	pattern = {
		[".*tmux.conf.tmpl"] = "tmux",
		[".*gitconfig.tmpl"] = "gitconfig",
	},
})
