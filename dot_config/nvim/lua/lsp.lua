local h = require('helpers')

local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

local function lsp_settings()
	vim.lsp.config('*', {
		capabilities = {
			textDocument = {
				semanticTokens = {
					multilineTokenSupport = true,
				}
			}
		},
		root_markers = { '.git' },
	})

	vim.diagnostic.config {
		severity_sort = true,
		underline = { severity = { min = vim.diagnostic.severity.WARN } },
		virtual_text = { severity = { min = vim.diagnostic.severity.WARN } }
	}
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '',
				[vim.diagnostic.severity.HINT] = '󰌵',
				[vim.diagnostic.severity.INFO] = '',
				-- [vim.diagnostic.severity.ERROR] = 'x',
				-- [vim.diagnostic.severity.WARN] = '!',
				-- [vim.diagnostic.severity.HINT] = '?',
				-- [vim.diagnostic.severity.INFO] = 'i',
			},
		},
	})

	-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
	-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

	vim.lsp.enable({ "gopls" })
	vim.lsp.enable({ "lua_ls" })
	vim.lsp.enable({ "marksman" })
	vim.lsp.enable({ "ts_ls" })
end

local function setup_completion(client, bufnr)
	local imap = h.mapper('i', { remap = false, silent = true, buffer = bufnr })
	local smap = h.mapper({ 'i', 's' }, { remap = false, silent = true, buffer = bufnr })
	-- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
	vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

	-- Use enter to accept completions.
	imap('<cr>', function()
		return pumvisible() and '<C-y>' or '<cr>'
	end, { expr = true })

	-- Use slash to dismiss the completion menu.
	imap('/', function()
		return pumvisible() and '<C-e>' or '/'
	end, { expr = true })

	smap('<Tab>', function()
		if vim.snippet.active { direction = 1 } then
			return '<cmd>lua vim.snippet.jump(1)<cr>'
		else
			return '<Tab>'
		end
	end, { expr = true })

	smap('<S-Tab>', function()
		if vim.snippet.active { direction = 1 } then
			return '<cmd>lua vim.snippet.jump(1)<cr>'
		else
			return '<S-Tab>'
		end
	end, { expr = true })

	imap('<C-space>', vim.lsp.completion.get, { desc = 'trigger lsp completion' })

	imap('<C-n>', function()
		if pumvisible() then
			h.feedkeys '<C-n>'
		else
			if next(vim.lsp.get_clients { bufnr = 0 }) then
				vim.notify('completing...')
				vim.lsp.completion.trigger()
			else
				if vim.bo.omnifunc == '' then
					h.feedkeys '<C-x><C-n>'
				else
					h.feedkeys '<C-x><C-o>'
				end
			end
		end
	end, { desc = 'Trigger/select next completion' })
end


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			vim.notify("LSP client not found", vim.log.levels.WARN)
			return
		end

		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		if client:supports_method('textDocument/completion') then
			-- Enable auto-completion
			-- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			-- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			setup_completion(client, ev.buf)
		end


		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local nmap = h.mapper('n', { buffer = ev.buf })
		local imap = h.mapper('i', { buffer = ev.buf })
		nmap('K', vim.lsp.buf.hover, { desc = 'documentation' })
		imap('<C-k>', vim.lsp.buf.signature_help, { desc = 'sig help' })
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
		-- nmap('<leader>lp', vim.diagnostic.goto_prev, { desc = 'prev diagnostic' })
		-- nmap('<leader>ln', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
		nmap('<leader>la', vim.lsp.buf.code_action, { desc = 'code actions menu' })
	end,
})


lsp_settings()
