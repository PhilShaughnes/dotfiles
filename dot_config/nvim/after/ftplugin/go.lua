vim.api.nvim_create_user_command('GoTidy', function()
	vim.cmd("!go mod tidy")
	vim.cmd("LspRestart")
end, {})
