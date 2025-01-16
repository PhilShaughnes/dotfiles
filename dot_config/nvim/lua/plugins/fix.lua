local M = {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				json = { "fixjson", "jq" },
				-- just = { "just" },
				go = { "goimports", "golines" },
				yaml = { "yamlfmt" },
				terraform = {},
			},
			-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePre" },
		config = function()
			require("lint").linters_by_ft = {
				-- yaml = { 'yamllint' },
				json = { "jq" },
				go = { "staticcheck" },
				-- javascript = { 'eslint' },
				typescript = { 'eslint' },
				terraform = { "tflint" },
			}
		end,
		keys = {
			{
				"<leader>lc",
				function()
					require("lint").try_lint()
				end,
				mode = "n",
				desc = "lint",
			},
		},
	},
}

local fixgroup = vim.api.nvim_create_augroup("fix", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = fixgroup,
	callback = function()
		require("lint").try_lint()
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

return M
