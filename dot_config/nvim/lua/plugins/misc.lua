local h = require('helpers')
local M = {
  { 'ojroques/nvim-osc52',             lazy = true }, -- probably can trigger this via keymaps
  { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {'<leader><leader>t', ':Neotree toggle<cr>', desc = 'toggle neotree'},
      {'<leader>nt', ':Neotree toggle<cr>', desc = 'toggle neotree'},
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  { 'RRethy/nvim-align', cmd = 'Align' },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
  },
  {
    'folke/flash.nvim',
    lazy = true,
    opts = {},
    init = function()
      local flash = h.lazyload('flash')
      h.map(
        { 'n', 'o', 'x' },
        '<leader>z',
        flash('treesitter'),
        { desc = 'flash treesitter' }
      )
      h.map(
        { 'o' },
        'r',
        flash('remote'),
        { desc = 'flash remote' }
      )
      h.map(
        { 'o', 'x' },
        'R',
        flash('treesitter_search'),
        { desc = 'flash treesitter search' }
      )
      h.map(
        { 'c' },
        '<C-x>',
        flash('toggle'),
        { desc = 'toggle flash search' }
      )
    end,
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    opts = {
      skip_ssl_verification = true,
    },
    keys = {
      { '<leader>rr', function() require('rest-nvim').run() end, desc = 'run rest call' }
    },
    -- init = function()
    --   local rest = function() require('rest-nvim').run() end
    --   h.nmap('<leader>rr', rest, {desc = 'run rest call'})
    -- end
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional
    },
    config = true,
    cmd = "Neogit",
  },
}

return M
