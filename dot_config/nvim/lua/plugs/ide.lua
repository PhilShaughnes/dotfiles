local function lsp_settings() 
	vim.diagnostic.config {
		severity_sort = true,
		underline = { severity = {min = vim.diagnostic.severity.WARN} },
		virtual_text = { severity = {min = vim.diagnostic.severity.WARN} }
	}

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
end

local M = {
	{
    "williamboman/mason.nvim",
		opts = { 
			-- ensure_installed = {
				-- "prettierd",
				-- "stylua",
				-- "selene",
				-- "luacheck",
				-- "eslint_d",
				-- "shellcheck",
				-- "shfmt",
			-- },
		},
  },
	{'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'},
	{
		"neovim/nvim-lspconfig",
		config = function()
			USER = vim.fn.expand("$HOME")

			local lspconfig = require('lspconfig')
			local lsp_defaults = lspconfig.util.default_config

			lsp_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lsp_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			lspconfig.tsserver.setup{}
			lspconfig.ember.setup{}
			lspconfig.jsonls.setup{}
			lspconfig.eslint.setup {
				-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript",
				-- "typescriptreact", "typescript.tsx", "vue", "json" }
			}
			lspconfig.bashls.setup{}
			lspconfig.dockerls.setup{}
			-- lspconfig.marksman.setup{}
			lspconfig.zk.setup{}
			lspconfig.sumneko_lua.setup {
				-- on_attach = function(_, _) -- client, bufnr
				-- 	end,
				settings = {
					Lua = {
						diagnostics = {
							globals = {'vim', 'hs'}
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
		end,
	}
}

return M
