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
		-- event = 'BufWinEnter',
		-- opts = { delay = 1 },
	},
	{
		'ivanjermakov/troublesum.nvim',
		config = { severity_format = { '', '', '', '󰌵' }, enabled = true },
		lazy = true,
		event = { "BufWritePost" },
		keys = {
			{
				'<leader>ud',
				function()
					local c = require("troublesum.config")
					local t = require("troublesum")
					if c.config.enabled == false then
						c.config.enabled = true
						require('troublesum').update()
					else
						require('troublesum').clear()
						c.config.enabled = false
					end
				end,
				desc = 'toggle diagnostics in corner'
			}
		},
	},
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
	{
		'nvim-lualine/lualine.nvim',
		-- event = 'VeryLazy',
		lazy = true,
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
					lualine_a = {
						{ 'mode', fmt = function(str) return str:sub(1, 1) end }
					},
					-- lualine_b = {
					--	 'branch', 'diff',
					-- },
					lualine_b = {
						'branch', 'diff', {
						'diagnostics',
						diagnostics_color = {
							error = { fg = get_fg({ 'DiagnosticError', 'DiagnosticSignError' }) },
							warn = { fg = get_fg({ 'DiagnosticWarn', 'DiagnosticSignWarn' }) },
							info = { fg = get_fg({ 'DiagnosticInfo', 'DiagnosticSignInfo' }) },
							hint = { fg = get_fg({ 'DiagnosticHint', 'DiagnosticSignHint' }) },
						}
					}
					},
					lualine_c = { 'filename' },
					lualine_x = { 'filetype' },
				}
			})
		end,
		dependencies = {
			-- 'WhoIsSethDaniel/lualine-lsp-progress.nvim',
			'kyazdani42/nvim-web-devicons',
		}
	},
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
		bg = 'light',
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
setTheme(M)

-- _G.colo = function(cs)
--	 cmd('colorscheme ' .. cs)
--	 sems()
--	 cmd([[highlight Normal guibg=none]])
-- end

_G.sems = sems
return M
