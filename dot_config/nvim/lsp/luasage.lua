-- == Configuration for Lua files ==
local function lua_ls_on_init(client)
	local path = vim.tbl_get(client, "workspace_folders", 1, "name")
	if not path then
		return
	end
	-- override the lua-language-server settings for Neovim config
	client.settings = vim.tbl_deep_extend('force', client.settings, {
		Lua = {
			diagnostics = {
				globals = { 'vim', 'hs' },
				unusedLocalExclude = { '_*' },
			},
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ";"),
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	})
end

return {
	name = "luasage",
	-- cmd = { 'sage', 'ls', '--cmd', mason_bin .. '/lua-language-server' },
	cmd = { 'sage', 'ls', '--cmd', 'lua-language-server' },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
	filetypes = { "lua" },
	on_init = lua_ls_on_init,
}
