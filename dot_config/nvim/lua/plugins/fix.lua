local h = require('helpers')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local clear_autocmds = vim.api.nvim_clear_autocmds
local M = {
	{
		"nvimdev/guard.nvim",
		lazy = true,
		cmd = "GuardFmt",
		config = function()
			local ft = require('guard.filetype')
			ft('just')
				:fmt({
					cmd = "just",
					args = { "--dump", "-f"},
					fname = true,
				})
			ft('html')
				:fmt({
					cmd = "prettierd",
					args = { '--stdin-filepath', },
					stdin = true,
					fname = true,
				})
				-- :fmt('prettier')
			require('guard').setup({fmt_on_save = false})
		end
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
	},
	{
		"mhartington/formatter.nvim",
		lazy = true,
		cmd = "Format",
		opts = {
			filetype = {
				just = function()
					return {
						exe = "just",
						args = { "--fmt", "--unstable", "-f" },
					}
				end,
				cue = {
					-- function()
					-- 	return { exe = "cueimports" }
					-- end,
					function()
						return { exe = "cue", args = { "fmt" } };
					end,
				},
				html = {
					function()
						return {
							exe = "prettierd",
							args = {},
							stdin = true,
						};
					end,
				},
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = { "go", "json", "just", "javascript", "cue", "json", "yaml", "proto" },
		opts = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports_reviser,
					null_ls.builtins.formatting.golines,
					null_ls.builtins.formatting.jq,
					-- null_ls.builtins.formatting.just,
					null_ls.builtins.formatting.cueimports,
					null_ls.builtins.formatting.cue_fmt,
					null_ls.builtins.diagnostics.cue_fmt,
					null_ls.builtins.diagnostics.vacuum,
					-- null_ls.builtins.diagnostics.buf,
					-- null_ls.builtins.formatting.buf,
					-- null_ls.builtins.diagnostics.protolint,
					-- null_ls.builtins.formatting.protolint,
				},
				on_attach = function(client, bufnr)
					local lspfmt = augroup('lspformatting', {})
					if client.supports_method("textDocument/formatting") then
						clear_autocmds({
							group = lspfmt,
							buffer = bufnr,
						})
						autocmd("BufWritePre", {
							group = lspfmt,
							buffer = bufnr,
							callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
						})
					end
				end
			})
		end,
		init = function()
			local toggle = function(source)
				return function()
					require('null-ls').toggle(source)
				end
			end
			h.nmap(
				"<leader>ltt",
				":lua require('null-ls').toggle('')<left><left>",
				{ desc = 'toggle null-ls', silent = false }
			)
			h.nmap("<leader>ltv", toggle('vacuum'), { desc = 'toggle vacuum' })
		end
	},
}

return M
