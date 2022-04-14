local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


cmp.setup {
	-- completion = {
	-- 	autocomplete = true
	-- },
	mapping = {
		['<c-d>'] = cmp.mapping.scroll_docs(-4),
		['<c-f>'] = cmp.mapping.scroll_docs(4),
		['<c-e>'] = cmp.mapping.close(),
		['<c-y>'] = cmp.mapping.confirm {
			behaviour = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		['<c-space>'] = cmp.mapping.complete(),

		["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
  sources = {
		{ name = 'nvim_lua' },
    { name = 'nvim_lsp', keyword_length = 3 },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer', keyword_length = 5 },
  },
	formatting = {
  format = require("lspkind").cmp_format({with_text = true, menu = ({
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      luasnip = "[snip]",
      nvim_lua = "[api]",
			path = "[path]",
    })}),
	},
}
