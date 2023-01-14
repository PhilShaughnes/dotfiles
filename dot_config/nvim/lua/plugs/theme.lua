local cmd = vim.cmd

local function get_fg(names)
  local utils = require('lualine.utils.utils')
  return utils.extract_color_from_hllist('fg', names, '#C26BDB')
end

local M = {
  { 'b0o/incline.nvim', config = true, event = "VeryLazy" },
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
					lualine_c = {'filename', 'lsp_progress'},
				}
			})
		end,
    dependencies = {
      'WhoIsSethDaniel/lualine-lsp-progress.nvim',
      'kyazdani42/nvim-web-devicons',
    }
	},
	{
		'NTBBloodbath/doom-one.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			cmd([[colorscheme doom-one]])
			cmd([[highlight Normal guibg=none]])
		end
	},
	{'projekt0n/github-nvim-theme', lazy = true}, -- github_dark_default
	{'tiagovla/tokyodark.nvim', lazy = true},
	{'ellisonleao/gruvbox.nvim', lazy = true},
}

return M
