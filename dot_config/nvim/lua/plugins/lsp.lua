local gopls_setup = {
	settings = {
		gopls = {
			-- completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}

local USER = vim.fn.expand("$HOME")
local lua_setup = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim', 'hs' },
				unusedLocalExclude = { '_*' },
			},
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";")
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
					[USER .. '/.Hammerspoon/Spoons/EmmyLua.spoon/annotations'] = true,
				}
			}
		}
	}
}

local M = {
	-- {
	-- 	'williamboman/mason-lspconfig.nvim',
	-- },
	{
		"williamboman/mason.nvim",
		version = "1.11.0",
		-- event = "VeryLazy",
		opts = {
			ensure_installed = {
				-- "prettierd",
				-- "stylua",
				-- "selene",
				-- "luacheck",
				-- "eslint_d",
				-- "shellcheck",
				-- "shfmt",
				-- "eslint-lsp",
				-- "golines",
				------ MAYBE INSTALL ------
				-- "prettier",
				-- "tflint",
				-- ""
				-- "gopls",
				"goimports",
				-- "typescript-language-server",
				"yamlfmt",
				-- "lua-language-server",
				-- "marksman",
			},
			automatic_installation = true,
		},
	},
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	init = function() end,
	-- 	config = function()
	-- 		local lspconfig = require('lspconfig')
	--
	-- 		lspconfig.ts_ls.setup {}
	-- 		lspconfig.dockerls.setup {}
	-- 		lspconfig.marksman.setup {}
	-- 		lspconfig.lua_ls.setup(lua_setup)
	-- 		lspconfig.gopls.setup(gopls_setup)
	-- 		-- lspconfig.sqls.setup {}
	-- 		-- lspconfig.terraform_ls.setup {}
	-- 		-- ◍ fixjson
	-- 		-- ◍ goimports
	-- 		-- ◍ jq
	-- 		-- ◍ staticcheck
	-- 		-- ◍ tflint
	-- 		-- ◍ yamlfmt
	-- 	end,
	-- }
}
-- local lsp_defaults = lspconfig.util.default_config
-- lspconfig.emmet_ls.setup {}
-- lspconfig.eslint.setup {
-- 	-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript",
-- 	-- "typescriptreact", "typescript.tsx", "vue", "json" }
-- }

return M
