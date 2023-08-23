local cmd = vim.cmd
local h = require('helpers')

local function get_fg(names)
  local utils = require('lualine.utils.utils')
  return utils.extract_color_from_hllist('fg', names, '#C26BDB')
end

local function sems()
  local links = {
    ['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
  }
  for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
  end
end

local M = {
  {
    'declancm/cinnamon.nvim',
    event = 'VeryLazy',
    opts = { default_delay = 1 },
  },
  {
    'b0o/incline.nvim',
    config = true,
    lazy = true,
    keys = {
      {'<leader><leader>i', function() require('incline').toggle() end, desc = 'toggle filename on screen'}
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          -- theme = 'horizon',
          -- theme = 'sonokai',
          component_separators = { '', '' },
          -- section_separators = {'', ''},
        },
        sections = {
          lualine_b = {
            'branch', 'diff', {
              'diagnostics',
              diagnostics_color = {
                error = { fg = get_fg({ 'DiagnosticError', 'DiagnosticSignError' }) },
                warn  = { fg = get_fg({ 'DiagnosticWarn', 'DiagnosticSignWarn' }) },
                info  = { fg = get_fg({ 'DiagnosticInfo', 'DiagnosticSignInfo' }) },
                hint  = { fg = get_fg({ 'DiagnosticHint', 'DiagnosticSignHint' }) },
              }
            }
          },
					lualine_c = {
            'filename',
            -- 'lsp_progress',
          },
				}
			})
		end,
    dependencies = {
      -- 'WhoIsSethDaniel/lualine-lsp-progress.nvim',
      'kyazdani42/nvim-web-devicons',
    }
	},
	{
		'NTBBloodbath/doom-one.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			cmd([[colorscheme doom-one]])
      sems()
			cmd([[highlight Normal guibg=none]])
		end
	},
	-- {'projekt0n/github-nvim-theme', lazy = true}, -- github_dark_default
	{
    'tiagovla/tokyodark.nvim',
    lazy = true,
		-- priority = 1000,
		-- config = function()
		-- 	cmd([[colorscheme tokyodark]])
		-- end
  },
	{
    'ellisonleao/gruvbox.nvim',
    lazy = true,
		-- priority = 1000,
		-- config = function()
		-- 	cmd([[colorscheme gruvbox]])
		-- 	cmd([[highlight Normal guibg=none]])
		-- end
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
		-- config = function()
		-- 	cmd([[colorscheme rose-pine-moon]])
		-- 	cmd([[highlight Normal guibg=none]])
		-- end
  },
  {
    'olivercederborg/poimandres.nvim',
    lazy = true,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
  }
}

_G.sems = sems
return M
