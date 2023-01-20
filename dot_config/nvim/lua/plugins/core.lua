local h = require('helpers')
local M = {
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  -- {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({}) end},
  { 'windwp/nvim-autopairs', opts = {}, event = 'InsertEnter' },
  { 'ojroques/nvim-osc52', lazy = true }, -- probably can trigger this via keymaps
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
  -- {'nvim-lua/plenary.nvim', lazy = true},
  { 'lewis6991/gitsigns.nvim', opts = {}, event = 'VeryLazy' },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    lazy = true,
    config = true,
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
      keymap = { builtin = {
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
      } }
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
  { 'RRethy/nvim-align', cmd = 'Align' },
  { 'folke/which-key.nvim', lazy = true },
  { 'sindrets/diffview.nvim', cmd = { 'DiffViewFileHistory', 'DiffviewOpen' } },
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    init = function()
      h.nmap('<leader>gg', ':Git<CR>', { desc = "open git view" })
    end
  },
  { 'kana/vim-niceblock', event = 'VeryLazy' },
  {
    'ggandor/leap.nvim',
    lazy = true,
    init = function()
      h.map({ 'n', 'v', 'o', 'x' }, '<leader>s', function()
        require('leap').leap { target_windows = { vim.fn.win_getid() } }
      end, { desc = "leap" })
    end
  },
}

return M
