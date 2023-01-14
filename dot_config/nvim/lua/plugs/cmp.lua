local M = {
  "hrsh7th/nvim-cmp",
  -- load cmp on InsertEnter
  event = "InsertEnter",
  -- these dependencies will only be loaded when cmp loads
  -- dependencies are always lazy-loaded unless specified otherwise
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
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
  cmp.event:on( 'confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({  map_char = { tex = '' } }))


  cmp.setup {
    -- completion = {
    --  autocomplete = true
    -- },
    mapping = {
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
      ['<c-d>'] = cmp.mapping.scroll_docs(-4),
      ['<c-f>'] = cmp.mapping.scroll_docs(4),
      ['<c-e>'] = cmp.mapping.close(),
      ['<c-y>'] = cmp.mapping.confirm {
        behaviour = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ['<c-space>'] = cmp.mapping.complete(),

      ["<Tab>"] = cmp.mapping(function(fallback)
        -- if cmp.visible() then
        --   cmp.select_next_item()
        -- elseif require('luasnip').expand_or_jumpable() then
        if require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
          if require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }
      ),
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

  -- cmp.setup.cmdline(':', {
  --   sources = {
  --     { name = 'cmdline' }
  --   }
  -- })
  -- cmp.setup.cmdline(":", {
  --   sources = cmp.config.sources({
  --     { name = "path" },
  --   }, {
  --     { name = "cmdline", keyword_length = 3 },
  --   }),
  -- })
  --
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })
end

return M
