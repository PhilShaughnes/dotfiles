local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local clear_autocmds = vim.api.nvim_clear_autocmds
local h = require('helpers')

local function lsp_settings()
	vim.diagnostic.config {
		severity_sort = true,
		underline = { severity = { min = vim.diagnostic.severity.WARN } },
		virtual_text = { severity = { min = vim.diagnostic.severity.WARN } }
	}

	-- local signs = {
	-- 	Error = '',
	-- 	-- Error = '',
	-- 	Warn = '',
	-- 	Info = '',
	-- 	Hint = '󰌵',
	-- }
	-- NON-NERDFONT
	-- Error = '✗',
	-- Error = '⊗',
	-- Warn = '⚠',
	-- Info = '⏼',
	-- Hint = '⊙',
	-- local signs = { Error = "⊗", Warn = "⚠", Hint = "⊙", Info = "⏼" }
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '',
				[vim.diagnostic.severity.HINT] = '󰌵',
				[vim.diagnostic.severity.INFO] = '',
				-- [vim.diagnostic.severity.ERROR] = '✘',
				-- [vim.diagnostic.severity.WARN] = '▲',
				-- [vim.diagnostic.severity.HINT] = '⚑',
				-- [vim.diagnostic.severity.INFO] = '»',
			},
		},
	})

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
end

local M = {
	{
		'j-hui/fidget.nvim',
		event = "LspAttach",
		opts = {},
	},
	-- {
	-- 	"icholy/lsplinks.nvim",
	-- 	lazy = true,
	-- 	config = true,
	-- },
	{
		"williamboman/mason.nvim",
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
				"eslint-lsp",
				"gopls",
				"golines",
				"goimports",
				"typescript-language-server",
				"yamllint",
				"jsonlint",
				"prettier",
				"lua-language-server",
			},
			automatic_installation = true,
		},
	},
	{
		"hinell/lsp-timeout.nvim",
		event = { "LspAttach" },
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
		end,
		config = function()
			lsp_settings()
			USER = vim.fn.expand("$HOME")

			local lspconfig = require('lspconfig')
			local lsp_defaults = lspconfig.util.default_config

			lsp_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lsp_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			lspconfig.tsserver.setup {}
			lspconfig.emmet_ls.setup {}
			lspconfig.eslint.setup {
				-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript",
				-- "typescriptreact", "typescript.tsx", "vue", "json" }
			}
			lspconfig.dockerls.setup {}
			-- lspconfig.marksman.setup{}
			lspconfig.lua_ls.setup {
				-- on_attach = function(_, _) -- client, bufnr
				-- 	end,
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
			lspconfig.gopls.setup {
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
		end,
	}
}


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- local gx = function() require("lsplinks").gx() end

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local nmap = h.mapper('n', { buffer = ev.buf })
		nmap('K', vim.lsp.buf.hover, { desc = 'documentation' })
		nmap('gd', vim.lsp.buf.definition, { desc = 'show definition' })
		nmap('gr', vim.lsp.buf.references, { desc = 'references' })
		-- nmap("gx", gx, { desc = 'go linked documentation' })

		nmap('<leader>lr', vim.lsp.buf.references, { desc = 'references' })
		nmap('<leader>ld', vim.lsp.buf.definition, { desc = 'show definition' })
		nmap('<leader>lD', vim.lsp.buf.declaration, { desc = 'show declaration' })
		nmap('<leader>li', vim.lsp.buf.implementation, { desc = 'show implementdation' })
		-- nmap('<leader>lf', vim.lsp.buf.format, { desc = 'format buffer' });
		-- vmap('<leader>lf', vim.lsp.buf.format, { desc = 'format buffer' });
		nmap('<leader>lk', vim.lsp.buf.hover, { desc = 'documentation' })
		nmap('<leader>lp', vim.diagnostic.goto_prev, { desc = 'prev diagnostic' })
		nmap('<leader>ln', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
		nmap('<leader>la', vim.lsp.buf.code_action, { desc = 'code actions menu' })
	end,
})

return M
