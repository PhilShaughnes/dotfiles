local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local cmd = vim.cmd  -- to call vim commands
local g = vim.g      -- a table to access global variables
local paqpath = vim.fn.expand("$HOME/.local/share/nvim/paq-plugins")

vim.opt.packpath:append(paqpath)
package.loaded['paq'] = nil
local paq = require "paq"
paq:setup({path=paqpath..'/'})

vim.opt.termguicolors = true

local function load_paq()
  -- cmd 'packadd paq-nvim'         -- Load package
  paq {

    {'savq/paq-nvim'};     -- Let Paq manage itself

    {'ibhagwan/fzf-lua'};
    {'numToStr/Comment.nvim'};
    {'tpope/vim-fugitive'};
    {'junegunn/gv.vim'};    -- :GV commit browser
    {'kevinhwang91/nvim-bqf'};
    {'markonm/traces.vim'};
    {'machakann/vim-sandwich'};
    {'kana/vim-niceblock'};
    {'luukvbaal/nnn.nvim'};


    {'tommcdo/vim-lion'};                              -- gl and gL align around a character (so glip=)
    {'justinmk/vim-gtfo'};                             -- got and gof open current file in terminal/file manager
    {'michaeljsmith/vim-indent-object'};               -- use indent level like ii or ai
    {'Darazaki/indent-o-matic'};

    {'akinsho/toggleterm.nvim'};

    {'nvim-treesitter/nvim-treesitter'};
    {'RRethy/nvim-treesitter-endwise'};
    {'p00f/nvim-ts-rainbow'};
    {'nvim-lua/plenary.nvim'};
    {'lewis6991/gitsigns.nvim'};
    {'nvim-telescope/telescope.nvim'};
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'};

    {'tpope/vim-projectionist', opt=true};
    {'vimwiki/vimwiki', opt = true};
    {'jakewvincent/mkdnflow.nvim'};
    {'folke/which-key.nvim'};
    {'linty-org/key-menu.nvim'};
    {'tversteeg/registers.nvim'};
    {'windwp/nvim-autopairs'};
    {'L3MON4D3/LuaSnip'};
    {'sindrets/diffview.nvim'};

    {'neovim/nvim-lspconfig'};
    {'williamboman/nvim-lsp-installer'};
    {'onsails/lspkind-nvim'};
    {'j-hui/fidget.nvim'}; -- nvim-lsp progress ui
    -- {'arkav/lualine-lsp-progress'};
    {'weilbith/nvim-code-action-menu'};
    {'hrsh7th/nvim-cmp'};
    {'hrsh7th/cmp-nvim-lsp'};
    {'hrsh7th/cmp-path'};
    {'hrsh7th/cmp-buffer'};
    {'hrsh7th/cmp-nvim-lua'};
    {'saadparwaiz1/cmp_luasnip'};

    {'mtdl9/vim-log-highlighting'};
    {'norcalli/nvim-colorizer.lua'};
    -- {'mattn/emmet-vim'};
    -- {'moll/vim-node'};
    -- {'jose-elias-alvarez/typescript.nvim'};

    -- {'vim-ruby/vim-ruby'};
    -- {'mhanberg/elixir.nvim'};
    {'folke/lua-dev.nvim'};

    {'kyazdani42/nvim-web-devicons'};
    {'sainnhe/sonokai'};
    {'wuelnerdotexe/vim-enfocado'};
    {'nvim-lualine/lualine.nvim'};
  }
end




function _G.try()
  require('fzf-lua').register_ui_select()

  vim.ui.select({'tabs', 'spaces'}, {
    prompt = "pick one:",
    format_item = function(item)
      return "chooses " .. item
    end,
  }, function(choice)
    if choice == 'spaces' then
      vim.notify("chose spaces!")
    else
      vim.notify("chose tabs!")
    end
  end
  )
  require('fzf-lua').deregister_ui_select()
end

local function gen_config()
  require('colorizer').setup({

  })
  -- require("typescript").setup()
  require('Comment').setup()
  require('indent-o-matic').setup({})
  require('nvim-autopairs').setup{}
  require('fidget').setup{}
  -- require('mkdnflow').setup({})
  -- require('fzf-lua').register_ui_select()
  require('telescope').load_extension('fzf')
end

local function theme_config()
  g['sonokai_menu_selection_background'] = 'red'
  g['sonokai_better_performance'] = 1
  -- sonokai styles: default, atlantis, andromeda, shusia, maia, espresso 
  -- default  : #2c2e34,
  -- andromeda: #2b2d3a,
  -- atlantis : #2a2f38,
  -- maia     : #273136,
  -- shusia   : #2d2a2e,
  -- espresso : #312c2b,
  --
  -- g['sonokai_style'] = 'espresso'
  -- g['sonokai_style'] = 'shusia'
  -- g['sonokai_style'] = 'default'
  g['sonokai_style'] = 'shusia'
  g['sonokai_diagnostic_text_highlight'] = 1
  g['sonokai_diagnostic_line_highlight'] = 1
  g['sonokai_diagnostic_virtual_text'] = 'colored'
  g['sonokai_enable_italic'] = 0
  g['sonokai_disable_italic_comment'] = 0
  -- g['enfocado_style'] = 'nature'
  g['enfocado_style'] = 'neon'
  cmd('colorscheme sonokai')
  -- cmd('colorscheme enfocado')
end

local function toggleterm_config()
    require('toggleterm').setup({
      size = function(term)
        print('running size!')
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
      -- direction = "vertical",
      -- open_mapping = [[C-t]]
    })
end

local function emmet_config()
  g['user_emmet_leader_key'] = ','
  g['user_emmet_settings'] = {
    javascript = { extends = "jsx" }
  }
end

local function nnn_config()
  require("nnn").setup({
    picker = {
      cmd = 'nnn -o',
      style = {
        width = 0.5,
        height = 0.7,
      }
    },
    explorer = { cmd = "nnn -o" },
    replace_netrw = 'picker',
  })
end

local function mkdnflow_config()
  require('mkdnflow').setup({
    mappings = {
      MkdnNextLink =           {'n', '<Tab>'},
      MkdnPrevLink =           {'n', '<S-Tab>'},
      MkdnNextHeading =        {'n', '<leader>]'},
      MkdnPrevHeading =        {'n', '<leader>['},
      MkdnGoBack =             {'n', '<leader>mb'},
      MkdnGoForward =          {'n', '<leader>mf'},
      MkdnFollowLink =         {{'n', 'v'}, '<CR>'},
      MkdnDestroyLink =        {'n', '<M-CR>'},
      MkdnYankAnchorLink =     {'n', '<leader>mya'},
      MkdnYankFileAnchorLink = {'n', '<leader>myf'},
      MkdnIncreaseHeading =    {'n', '='},
      MkdnDecreaseHeading =    {'n', '-'},
      MkdnToggleToDo =         {{'n', 'v'}, '<leader>x'},
      MkdnNewListItem =        {'i', '<CR>'},
      MkdnMoveSource =         {'n', '<leader>mr'},
      MkdnExtendList = false,
      MkdnUpdateNumbering =    {'n', '<leader>mn'}
    }
  })
end
-- mkdnflow_config()

local function vimwiki_config()
  -- local nested = {
  --   python = 'python',
  --   elixir = 'elixir',
  --   js = 'javascript',
  -- }

  g.vimwiki_list = {
    {
      path = '~/vimwiki',
      syntax = 'default',
      ext = '.wiki'
    },
    -- {
    --   path = '~/vimwiki_md',
    --   syntax = 'markdown',
    --   ext = '.md'
    -- }
  }

  -- map('n', '<leader>x', '<Plug>VimwikiToggleListItem', {noremap = false})
  -- map('v', '<leader>x', '<Plug>VimwikiToggleListItem', {noremap = false})
  -- map('n', '<leader><backspace>', '<Plug>VimwikiGoBackLink', {noremap = false})
  -- map('n', '<leader>=', '<Plug>VimwikiAddHeaderLevel', {noremap = false})
  -- map('n', '<leader>-', '<Plug>VimwikiRemoveHeaderLevel', {noremap = false})

end

local function gitsigns_config()
    require('gitsigns').setup({
    signs = {
      add          = {hl = 'GitGutterAdd'   },
      change       = {hl = 'GitGutterChange'},
      delete       = {hl = 'GitGutterDelete'},
      topdelete    = {hl = 'GitGutterDelete'},
      changedelete = {hl = 'GitGutterChange'},
    }
  })
end

local function treesitter_config()
  g.markdown_fenced_languages = {
    'bash=sh', 'js=javascript', 'json', 'ruby', 'lua',
    'html', 'css', 'sql', 'java',
  }
  require'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "ruby", "bash", "c", "cmake", "comment", "css",
    "dockerfile", "eex", "elixir", "erlang", "glimmer", "go", "graphql",
    "heex", "help", "html", "java", "javascript", "jsdoc", "json", "lua",
    "make", "python", "regex", "rust", "scss", "toml",
    "typescript", "tsx", "vim", "vue", "yaml", "hcl",},
    -- ignore_install = {"elixir"},
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { "rust" },  -- list of language that will be disabled
    },
    endwise = { enable = true },
    -- rainbow = { enable = true },
    rainbow = { enable = false },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "gnn",
    --     node_incremental = "grn",
    --     scope_incremental = "grc",
    --     node_decremental = "grm",
    --   },
    -- },
    -- rainbow = { enable = true },
    -- indent = { enable = true },
  }

  -- cmd 'set foldmethod=expr'
  -- cmd 'set foldexpr=nvim_treesitter#foldexpr()'
  -- vim.wo.foldmethod = expr
  -- vim.wo.foldexpr = some function
end

local function get_fg(names)
  local utils = require('lualine.utils.utils')
  return utils.extract_color_from_hllist('fg', names, '#C26BDB')
end

function _G.lualine_config()
  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = {'', ''},
      -- section_separators = {'', ''},
    },
    sections = {
      lualine_b = {
        'branch', 'diff', {
          'diagnostics',
          diagnostics_color = {
            error = { fg = get_fg({'DiagnosticError', 'DiagnosticSignError'})},
            warn  = { fg = get_fg({'DiagnosticWarn',  'DiagnosticSignWarn' })},
            info  = { fg = get_fg({'DiagnosticInfo',  'DiagnosticSignInfo' })},
            hint  = { fg = get_fg({'DiagnosticHint',  'DiagnosticSignHint' })},
          }
        }
      },
      lualine_c = {'filename', 'lsp_progress'},
    }
  })
end

load_paq()
gen_config()
theme_config()
nnn_config()
lualine_config()
gitsigns_config()
treesitter_config()
toggleterm_config()
-- vimwiki_config()
emmet_config()

