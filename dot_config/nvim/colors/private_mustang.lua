-- Set background to dark
vim.o.background = "dark"

-- Clear highlights
vim.cmd("hi clear")

-- Reset syntax if it exists
if vim.g.syntax_on then
	vim.cmd("syntax reset")
end

-- Set the colorscheme name
vim.g.colors_name = "mustang"

-- General colors
vim.api.nvim_set_hl(0, "Cursor", { bg = "#626262", ctermbg = 241 })
vim.api.nvim_set_hl(0, "Normal", { fg = "#e2e2e5", bg = "#202020", ctermfg = 253, ctermbg = 234 })
vim.api.nvim_set_hl(0, "NonText", { fg = "#808080", bg = "#202020", ctermfg = 244, ctermbg = 235 })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#808080", bg = "#202020", ctermfg = 244, ctermbg = 232 })
vim.api.nvim_set_hl(0, "StatusLine",
	{ fg = "#d3d3d5", bg = "#444444", italic = true, ctermfg = 253, ctermbg = 238, cterm = { italic = true } })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#939395", bg = "#444444", ctermfg = 246, ctermbg = 238 })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#444444", bg = "#444444", ctermfg = 238, ctermbg = 238 })
vim.api.nvim_set_hl(0, "Folded", { fg = "#a0a8b0", bg = "#202020", ctermfg = 248, ctermbg = 4 })
vim.api.nvim_set_hl(0, "Title", { fg = "#f6f3e8", bold = true, ctermfg = 254, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "Visual", { fg = "#faf4c6", bg = "#3c414c", ctermfg = 254, ctermbg = 4 })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#808080", bg = "#202020", ctermfg = 244, ctermbg = 236 })

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2d2d2d", ctermbg = 236 })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2d2d2d", ctermbg = 236 })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2d2d2d", ctermbg = 236 })
vim.api.nvim_set_hl(0, "MatchParen",
	{ fg = "#d0ffc0", bg = "#2f2f2f", bold = true, ctermfg = 157, ctermbg = 237, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#ffffff", bg = "#444444", ctermfg = 255, ctermbg = 238 })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#000000", bg = "#b1d631", ctermfg = 0, ctermbg = 148 })

-- Syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = "#808080", italic = true, ctermfg = 244 })
vim.api.nvim_set_hl(0, "Todo", { fg = "#8f8f8f", italic = true, ctermfg = 245 })
vim.api.nvim_set_hl(0, "Boolean", { fg = "#b1d631", ctermfg = 148 })
vim.api.nvim_set_hl(0, "String", { fg = "#b1d631", italic = true, ctermfg = 148 })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#b1d631", ctermfg = 148 })
vim.api.nvim_set_hl(0, "Function", { fg = "#ffffff", bold = true, ctermfg = 255 })
vim.api.nvim_set_hl(0, "Type", { fg = "#7e8aa2", ctermfg = 103 })
vim.api.nvim_set_hl(0, "Statement", { fg = "#7e8aa2", ctermfg = 103 })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#ff9800", ctermfg = 208 })
vim.api.nvim_set_hl(0, "Constant", { fg = "#ff9800", ctermfg = 208 })
vim.api.nvim_set_hl(0, "Number", { fg = "#ff9800", ctermfg = 208 })
vim.api.nvim_set_hl(0, "Special", { fg = "#ff9800", ctermfg = 208 })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#faf4c6", ctermfg = 230 })
vim.api.nvim_set_hl(0, "Todo", { fg = "#000000", bg = "#e6ea50", italic = true })
