
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local paqpath = vim.fn.expand("$HOME/.local/share/nvim/paq-plugins")

vim.opt.packpath:append(paqpath)
local paq = require "paq"
paq:setup({paqdir=paqpath..'/'})

vim.opt.termguicolors = true

local function load_paq()
  -- cmd 'packadd paq-nvim'         -- Load package
  paq {

    {'savq/paq-nvim'};     -- Let Paq manage itself

    {'ibhagwan/fzf-lua'};
    {'numToStr/Comment.nvim'};
    {'tpope/vim-fugitive'};
    {'junegunn/gv.vim'};
    {'romainl/vim-qf'};
    {'romainl/vim-cool'};
    {'markonm/traces.vim'};
    {'machakann/vim-sandwich'};
    {'kana/vim-niceblock'};


    -- {'rbgrouleff/bclose.vim'};                         -- close buffer without closing windows
    {'tommcdo/vim-lion'};                              -- gl and gL align around a character (so glip=)
    {'justinmk/vim-gtfo'};                             -- got and gof open current file in terminal/file manager
    -- {'jeetsukumaran/vim-indentwise'};
    {'michaeljsmith/vim-indent-object'};               -- use indent level like ii or ai
    -- {'tpope/vim-sleuth'};
    {'Darazaki/indent-o-matic'};

    -- {'numtostr/FTerm.nvim'};
    {'akinsho/toggleterm.nvim'};

    -- {'nathom/filetype.nvim'};
    {'nvim-treesitter/nvim-treesitter'};
    {'RRethy/nvim-treesitter-endwise'};
    {'p00f/nvim-ts-rainbow'};
    {'nvim-lua/plenary.nvim'};
    {'lewis6991/gitsigns.nvim'};
    {'mcchrish/nnn.vim'};

    {'tpope/vim-projectionist', opt=true};
    {'vimwiki/vimwiki'};
    -- {'dkarter/bullets.vim'};
    -- {'jakewvincent/mkdnflow.nvim'};
    {'folke/which-key.nvim'};
    {'windwp/nvim-autopairs'};
    {'L3MON4D3/LuaSnip'};

    {'neovim/nvim-lspconfig'};
    {'williamboman/nvim-lsp-installer'};
    {'onsails/lspkind-nvim'};
    {'ray-x/lsp_signature.nvim'};
    {'weilbith/nvim-code-action-menu'};
    {'hrsh7th/nvim-cmp'};
    {'hrsh7th/cmp-nvim-lsp'};
    {'hrsh7th/cmp-path'};
    {'hrsh7th/cmp-buffer'};
    {'hrsh7th/cmp-nvim-lua'};
    {'saadparwaiz1/cmp_luasnip'};


    {'mtdl9/vim-log-highlighting'};
    {'othree/csscomplete.vim'};
    {'norcalli/nvim-colorizer.lua'};
    {'alvan/vim-closetag'};
    {'mattn/emmet-vim'};
    {'moll/vim-node'};
    {'pangloss/vim-javascript'};

    {'vim-ruby/vim-ruby'};
    {'elixir-editors/vim-elixir'};
    -- {'xolox/vim-misc'};
    -- {'xolox/vim-lua-ftplugin'};
    -- {'cespare/vim-toml'};
    -- {'fatih/vim-go'};
    -- {'mrk21/yaml-vim'};
    {'junegunn/goyo.vim'};                             -- distraction free vim
    {'junegunn/limelight.vim'};

    {'kyazdani42/nvim-web-devicons'};
    {'sainnhe/sonokai'};
    {'sainnhe/edge'};
    {'folke/tokyonight.nvim'};
    {'wuelnerdotexe/vim-enfocado'};
    {'nvim-lualine/lualine.nvim'};
  }
end

local function gen_config()
  require('colorizer').setup()
  require('Comment').setup()
  require('indent-o-matic').setup({})
  require('nvim-autopairs').setup{}
  -- require('mkdnflow').setup({})
  g['tokyonight_style'] = 'night'
  -- g['enfocado_style'] = 'nature'
  g['enfocado_style'] = 'neon'

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

local function filetype_config()
  -- In init.lua or filetype.nvim's config file
  -- use extension or literal overrides before complex if possible for perf
  require("filetype").setup({
    overrides = {
      extensions = {
        -- Set the filetype of *.pn files to potion
        log = "log",
        hbs = "handlebars",
      },
      literal = {
        -- Set the filetype of files named "MyBackupFile" to lua
        -- MyBackupFile = "lua",
        ["dot_tmux.conf.tmpl"] = "tmux",
        ["dot_gitconfig.tmpl"] = "gitconfig",
      },
      complex = {
        -- Set the filetype of any full filename matching the regex to gitconfig
        -- [".*git/config"] = "gitconfig", -- Included in the plugin
      },

      -- The same as the ones above except the keys map to functions
      function_extensions = {
        ["cpp"] = function()
          vim.bo.filetype = "cpp"
          -- Remove annoying indent jumping
          vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
        end,
        ["pdf"] = function()
          vim.bo.filetype = "pdf"
          -- Open in PDF viewer (Skim.app) automatically
          vim.fn.jobstart(
            "open " .. '"' .. vim.fn.expand("%") .. '"'
          )
        end,
      },
      -- function_literal = {
      --  Brewfile = function()
      --    vim.cmd("syntax off")
      --  end,
      -- },
      -- function_complex = {
      --  ["*.math_notes/%w+"] = function()
      --    vim.cmd("iabbrev $ $$")
      --  end,
      -- },

      shebang = {
        -- Set the filetype of files with a dash shebang to sh
        dash = "sh",
      },
    },
  })
end

local function emmet_config()
  g['user_emmet_leader_key'] = ','
  g['user_emmet_settings'] = {
    javascript = { extends = "jsx" }
  }
end

local function vim_nnn_config()
  require('nnn').setup({
    set_default_mappings = 0,
    replace_netrw = 1,
    command = 'nnn -o',
    layout = {
      window = {
        width = 0.5,
        height = 0.7,
        highlight = 'debug'
      }
    }
  })
end

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
    'bash=sh', 'js=javascript', 'json', 'ruby', 'lua', 'elixir',
    'html', 'css', 'sql', 'java',
  }
  require'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "ruby", "bash", "c", "cmake", "comment", "css",
      "dockerfile", "eex", "elixir", "erlang", "glimmer", "go", "graphql",
      "heex", "help", "html", "java", "javascript", "jsdoc", "json", "lua",
      "make", "python", "regex", "rust", "scss", "toml", "typescript", "tsx",
      "vim", "vue", "yaml", },
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

function _G.lualine_config()
  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = {'', ''},
      -- section_separators = {'', ''},
    }
  })

end

load_paq()
gen_config()
vim_nnn_config()
lualine_config()
gitsigns_config()
treesitter_config()
-- filetype_config()
toggleterm_config()
-- require 'config/cmp_config'
-- require 'config/keys'
vimwiki_config()
emmet_config()
