local h = require('helpers')
local M = {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      local ft = require('Comment.ft')
      ft.yaml = '#%s'
      ft({ 'toml', 'graphql', 'hurl' }, '#%s')
    end
  },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  -- {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({}) end},
  { 'windwp/nvim-autopairs', opts = {}, event = 'InsertEnter' },
  {
    'kylechui/nvim-surround',
    opts = {
      move_cursor = false,
      keymaps = {
        normal = "sa",
        delete = "sd",
        change = "sr",
        visual = "sa",
        visual_line = "Sa",
      },
    }
  },
  { 'Darazaki/indent-o-matic', opts = {}, event = 'VeryLazy' },
  { 'lewis6991/gitsigns.nvim', opts = {}, event = 'VeryLazy' },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    lazy = true,
    config = true,
    opts = {
      autoswitch = {
        enable = true,
      }
    },
    init = function()
      local possession = h.lazyload('nvim-possession')
      h.nmap("<leader>sl", possession('list'), { desc = 'session list' })
      h.nmap("<leader>sn", possession('new'), { desc = 'new session' })
      h.nmap("<leader>su", possession('update'), { desc = 'update session' })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    lazy = true,
    opts = {
      keymap = {
        builtin = {
          ["<C-f>"]    = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<C-w>"]    = "toggle-preview-wrap",
          ["<C-p>"]    = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<C-l>"]    = "toggle-preview-ccw",
          ["<C-h>"]    = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"]   = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        }
      }
    }
  },
  {
    'luukvbaal/nnn.nvim',
    cmd = 'NnnPicker',
    config = function()
      require('nnn').setup({
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
    end,
    init = function()
      h.nmap('<leader>nn', ':NnnPicker<CR>', { desc = "nnn window in root" })
      h.nmap('<leader>nm', ":NnnPicker %:p:h<CR>", { desc = "nnn window in dir of current file" })
      h.nmap('<leader>nr', ":NnnExplorer<CR>", { desc = "nnn sidebar in root" })
      h.nmap('<leader>nl', ":NnnExplorer %:p:h<CR>", { desc = "nnn sidebar in dir of current file" })
    end
  },
  {
    'Wansmer/treesj',
    cmd = 'TSJToggle',
    dependencies = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false },
    init = function()
      h.nmap('<leader>v', ':TSJToggle<cr>', { desc = 'toggle joins' })
    end,
  },
  { 'folke/which-key.nvim', lazy = true },
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    init = function()
      h.nmap('<leader>gg', ':Git<CR>', { desc = "open git view" })
    end
  },
  {
    'ThePrimeagen/harpoon',
    lazy = true,
    init = function()
      local add = function() require('harpoon.mark').add_file() end
      local hp = h.lazyload('harpoon.ui')

      h.nmap('<leader>pp', hp('toggle_quick_menu'), { desc = 'harpoon menu' })
      h.nmap('<C-l>', hp('nav_next'), { desc = 'harpoon next' })
      h.nmap('<C-h>', hp('nav_prev'), { desc = 'harpoon prev' })
      h.nmap('<leader>1', hp('nav_file', 1), { desc = 'harpoon 1' })
      h.nmap('<leader>2', hp('nav_file', 2), { desc = 'harpoon 2' })
      h.nmap('<leader>3', hp('nav_file', 3), { desc = 'harpoon 3' })
      h.nmap('<leader>4', hp('nav_file', 4), { desc = 'harpoon 4' })
      h.nmap('<leader>0', add, { desc = 'harpoon add' })
    end
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { mappings = nil },
    lazy = true,
    init = function()
      local gl = function(mode, opts)
        return function() require "gitlinker".get_buf_range_url(mode, opts) end
      end
      h.nmap('<leader>gy', gl('n'), { desc = 'yank github link' })
      h.vmap('<leader>gy', gl('v'), { desc = 'yank github link' })
    end
  },
  { 'kana/vim-niceblock',   event = 'VeryLazy' },
}

return M
