vim.filetype.add({
	extension = {
		sh = "bash",
		log = "log",
		sql = "sql",
		tf = "hcl",
		http = "hurl",
		hurl = "hurl",
		tftpl = "yaml",
		gitconfig = "gitconfig",
	},
	filename = {
		['justfile'] = "just",
		['.env.local'] = "sh",
		['config'] = "conf",
		-- ['dot_tmux.conf.tmpl'] = "tmux",
		-- ['dot_gitconfig.tmpl'] = "gitconfig",
	},
	pattern = {
		[".*tmux.conf.tmpl"] = "tmux",
		[".*gitconfig.tmpl"] = "gitconfig",
	},
})
