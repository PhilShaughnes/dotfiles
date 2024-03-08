local h = require('helpers')

local M = {
	"hrsh7th/nvim-cmp",
	-- load cmp on InsertEnter
	event = "InsertEnter",
	-- these dependencies will only be loaded when cmp loads
	-- dependencies are always lazy-loaded unless specified otherwise
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-buffer",
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		{
			'dcampos/nvim-snippy',
			opts = {
				mappings = {
					is = {
						['<c-j>'] = 'expand_or_advance',
						['<c-k>'] = 'previous',
					},
					nx = {
						['<leader>x'] = 'cut_text',
					},
				},
			}
		},
		'dcampos/cmp-snippy',
		-- {
		--	 'L3MON4D3/LuaSnip',
		--	 config = function()
		--		 require("luasnip.loaders.from_snipmate").lazy_load()
		--		 local ls = require("luasnip")
		--		 h.map({ 'i', 's' }, '<C-j>', function()
		--			 if ls.expand_or_jumpable() then
		--				 ls.expand_or_jump()
		--			 end
		--		 end, { desc = "expand or jump fwd in snippet" })
		--		 h.map({ 'i', 's' }, '<C-k>', function()
		--			 if ls.jumpable(-1) then
		--				 ls.jump(-1)
		--			 end
		--		 end, { desc = "jump back in snippet" })
		--	 end
		-- },
		-- 'saadparwaiz1/cmp_luasnip',
		-- 'hrsh7th/cmp-nvim-lua',
		'onsails/lspkind-nvim',
	},
}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


function M.config()
	local cmp = require('cmp')
	-- cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } }))


	cmp.setup {
		-- completion = {
		--	autocomplete = true
		-- },
		mapping = {
			-- ['<C-t>'] = cmp.mapping.complete({ config = { sources = { name = 'luasnip' } } }),
			['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
			['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
			['<c-u>'] = cmp.mapping.scroll_docs(-4),
			['<c-d>'] = cmp.mapping.scroll_docs(4),
			['<c-e>'] = cmp.mapping.close(),
			['<c-y>'] = cmp.mapping.confirm {
				behaviour = cmp.ConfirmBehavior.Insert,
				select = true,
			},
			['<c-space>'] = cmp.mapping.complete(),
		},
		snippet = {
			expand = function(args)
				require('snippy').expand_snippet(args.body)
				-- require('luasnip').lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = 'snippy',   keyword_length = 2 },
			-- { name = 'luasnip',	keyword_length = 3 },
			{ name = 'nvim_lsp', keyword_length = 2 },
			{ name = 'path' },
			-- { name = 'nvim_lua' },
			-- { name = 'buffer', keyword_length = 5 },
		},
		formatting = {
			format = require("lspkind").cmp_format({ with_text = true, menu = ({
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				-- luasnip = "[snip]",
				snippy = "[snip]",
				-- nvim_lua = "[api]",
				path = "[path]",
			}) }),
		},
	}

	-- cmp.setup.cmdline(':', {
	--	 sources = {
	--		 { name = 'cmdline' }
	--	 }
	-- })
	-- cmp.setup.cmdline(":", {
	--	 sources = cmp.config.sources({
	--		 { name = "path" },
	--	 }, {
	--		 { name = "cmdline", keyword_length = 1 },
	--	 }),
	-- })

	-- cmp.setup.cmdline('/', {
	--	 sources = {
	--		 { name = 'buffer' }
	--	 }
	-- })
end

return M
