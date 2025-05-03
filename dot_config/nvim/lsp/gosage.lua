-- == Configuration for Go files ==
return {
	name = "gosage",
	cmd = { 'sage', 'ls', '--cmd', 'gopls' },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
