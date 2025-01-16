local cmd = vim.cmd

local function fire()
	cmd [[colo default]]
	local group_styles = {
		['Normal']          = { fg = '#311126', bg = 'None' },
		['Statement']       = { fg = '#311126', bold = true },
		['Comment']         = { fg = '#9893a5', italic = true },
		['String']          = { fg = '#276983', italic = true },
		['Function']        = { fg = '#575279' },

		['Structure']       = { fg = '#8a2e33' },
		['Constant']        = { fg = '#a63e35', italic = true },
		['PreProc']         = { fg = '#575279', bold = true },
		['type']            = { fg = '#a63e35' },

		['StatusLine']      = { fg = '#191724', bg = '#f2e9e1' },
		['Visual']          = { bg = '#dfdad9' },
		['ColorColumn']     = { bg = '#f4ede8' },
		['NormalFloat']     = { bg = '#f4ede8' },
		['Pmenu']           = { fg = '#311126', bg = '#f4ede8' },

		['DiagnosticHint']  = { fg = '#907aa9', },
		['DiagnosticInfo']  = { fg = '#56949f', },
		['DiagnosticWarn']  = { fg = '#ea9d34', },
		['DiagnosticError'] = { fg = '#b4637a', },
	}
	for group, style in pairs(group_styles) do
		vim.api.nvim_set_hl(0, group, style)
	end
end

local function ropi()
	cmd [[colo default]]
	local group_styles = {
		['Normal']    = { fg = '#311126', bg = 'None' },
		['Statement'] = { fg = '#341956', bold = true },
		['Comment']   = { fg = '#9893a5', italic = true },
		['String']    = { fg = '#5d3ead', italic = true },
		['Function']  = { fg = '#575279' },


		-- ['Normal']          = { fg = '#575279', bg = 'None' },
		-- ['Statement']       = { fg = '#575279', bold = true },
		-- ['Comment']         = { fg = '#9893a5', italic = true },
		-- ['String']          = { fg = '#b4637a', italic = true },
		-- ['Function']        = { fg = '#575279' },
		-- ['Function']        = { fg = '#286983' },
		-- ['Identifier']  = { fg = '#d7827e' },
		-- ['Special']         = { fg = '#ea9d34', bold = true },


		['Structure']       = { fg = '#341956' },
		['Constant']        = { fg = '#72197c', italic = true },
		['PreProc']         = { fg = '#575279', bold = true },
		['type']            = { fg = '#2b2b69' },
		-- ['Structure']       = { fg = '#ea9d34' },
		-- ['Constant']        = { fg = '#575279', italic = true },
		-- ['PreProc']         = { fg = '#907aa9', bold = true },
		-- ['type']            = { fg = '#d7827e', bold = true },

		['StatusLine']      = { fg = '#191724', bg = '#f2e9e1' },
		['Visual']          = { bg = '#dfdad9' },
		['ColorColumn']     = { bg = '#f4ede8' },
		['NormalFloat']     = { bg = '#f4ede8' },
		['Pmenu']           = { fg = '#311126', bg = '#f4ede8' },

		['DiagnosticHint']  = { fg = '#907aa9' },
		['DiagnosticInfo']  = { fg = '#56949f' },
		['DiagnosticWarn']  = { fg = '#ea9d34' },
		['DiagnosticError'] = { fg = '#b4637a' },


		-- ['Normal']                = { fg = '#cccccc', bg = 'None' },
		-- ['Comment']               = { fg = '#777777' },
		-- ['String']                = { fg = '#bbbbbb' },
		-- ['Function']              = { fg = '#bbbbbb' },
		-- ['Identifier']            = { fg = '#dddddd', bold = true },
		-- ['Special']               = { fg = '#bbbbbb' },
		-- ['Question']              = { fg = '#666666' },
		-- ['Directory']             = { fg = '#777777' },
		--
		-- ['MoreMsg']               = { fg = '#eeeeee', bg = '#444444' },
		-- ['QuickFixLine']          = { fg = '#eeeeee', bg = '#444444' },
		-- ['StatusLine']            = { fg = '#333333', bg = '#222222' },
		-- ['NormalFloat']           = { bg = 'None' },
		--
		-- ['Folded']                = { fg = '#444444' },
		-- ['MatchParen']            = { fg = '#ffffff', bold = true },
		-- ['WinSeparator']          = { fg = '#444444' },
		--
		-- ['Search']                = { fg = '#000000', bg = '#777777' },
		-- ['CurSearch']             = { fg = '#000000', bg = '#aaaaaa' },
		--
		-- ['DiagnosticUnnecessary'] = { fg = '#bbbbbb' },
		--
	}

	for group, style in pairs(group_styles) do
		vim.api.nvim_set_hl(0, group, style)
	end
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
		'norcalli/nvim-colorizer.lua',
		opts = {},
		lazy = true,
		keys = {
			{
				'<leader>uc',
				function()
					local c = require 'colorizer'
					if c.is_buffer_attached(0) then
						c.detach_from_buffer(0)
						package.loaded['colorizer'] = nil
					else
						package.loaded['colorizer'] = nil
						require('colorizer').attach_to_buffer(0)
					end
				end,
				desc = 'toggle colorizer'
			}
		},
	},
	{
		'declancm/cinnamon.nvim',
		event = 'VeryLazy',
		-- event = 'BufWinEnter',
		-- opts = { delay = 1 },
	},
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
	{
		'EdenEast/nightfox.nvim',
		bg = 'dark',
		colo = 'terafox',
		lazy = true,
	},
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		colo = 'rose-pine',
		lazy = true,
	},
	{
		'mcchrish/zenbones.nvim',
		-- bg = 'light',
		colo = 'zenbones',
		lazy = true,
		-- priority = 1000,
		-- init = function()
		-- 	vim.g.zenbones_compat = 1
		-- 	vim.g.zenbones_solid_line_nr = true
		-- 	vim.g.zenbones_darken_comments = 45
		-- end
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = true,
		-- lazy = false,
		-- priority = 1000,
		opt = {
			compile = false,
			transparent = false,
		},
	},
	-- {
	-- 	dir = '~/.config/nvim/lua/my/colors.lua',
	--
	-- 	event = 'UIEnter',
	--
	-- 	config = function()
	-- 		require('my.colors').setup {
	-- 			flavour = 'grayscale',
	-- 		}
	-- 	end
	-- },
}
local function setTheme(colorschemeTable)
	local currentbg = vim.o.background
	for i, config in ipairs(colorschemeTable) do
		if config.bg and config.bg == currentbg then
			config.lazy = false
			config.priority = 1000
			config.config = function() vim.cmd("colorscheme " .. config.colo) end
		end
	end
end
-- setTheme(M)

-- _G.colo = function(cs)
--	 cmd('colorscheme ' .. cs)
--	 sems()
--	 cmd([[highlight Normal guibg=none]])
-- end

_G.sems = sems
_G.ropi = ropi
_G.fire = fire
return M
