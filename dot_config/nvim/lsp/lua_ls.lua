-- local USER = vim.fn.expand("$HOME")
local function lua_ls_on_init(client)
	if client.workspace_folders then
		local path = client.workspace_folders[1].name
		if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
			return
		end
	end

	-- override the lua-language-server settings for Neovim config
	client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
		diagnostics = {
			globals = { 'vim', 'dump' },
		},
		runtime = {
			version = 'LuaJIT',
			-- path = vim.split(package.path, ";"),
		},
		-- Make the server aware of Neovim runtime files
		workspace = {
			checkThirdParty = false,
			library = {
				vim.env.VIMRUNTIME,
				-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
				-- Depending on the usage, you might want to add additional paths here.
				-- "${3rd}/luv/library"
				-- "${3rd}/busted/library",
			}
			-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
			-- library = vim.api.nvim_get_runtime_file("", true)
		},
	})
end

-- ---@type vim.lsp.Config
-- return {
-- 	cmd = { "lua-language-server" },
-- 	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
-- 	filetypes = { "lua" },
-- 	on_init = lua_ls_on_init,
-- }
--
--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
---
return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
		'.git',
	},
	on_init = lua_ls_on_init,
	settings = {
		Lua = {
			diagnostics = {
				unusedLocalExclude = { '_*' },
			},
		},
	},
}
