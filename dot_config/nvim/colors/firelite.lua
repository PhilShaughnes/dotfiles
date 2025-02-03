vim.cmd("hi clear")
vim.g.colors_name = "firelite"

local function adjust_brightness(hex, factor)
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	local function adjust(value)
		value = value + (255 - value) * factor
		return math.max(0, math.min(255, math.floor(value)))
	end

	r = adjust(r)
	g = adjust(g)
	b = adjust(b)

	return string.format("#%02X%02X%02X", r, g, b)
end

-- comment
local group_styles = {
	-- ["Normal"] = { fg = "#311126", bg = "None" },
	["Normal"] = { fg = "#311126", bg = "#faf4ed" },
	["Statement"] = { fg = "#311126", bold = true },
	["Comment"] = { fg = "#9893a5", italic = true },
	["String"] = { fg = "#276983", italic = true },
	["Function"] = { fg = "#575279" },

	["Structure"] = { fg = "#8a2e33" },
	["Constant"] = { fg = "#a63e35", italic = true },
	["PreProc"] = { fg = "#575279", bold = true },
	["type"] = { fg = "#a63e35" },

	["StatusLine"] = { fg = "#191724", bg = "#f2e9e1" },
	["Visual"] = { bg = "#dfdad9" },
	["ColorColumn"] = { bg = "#f4ede8" },
	["NormalFloat"] = { bg = "#f4ede8" },
	["Pmenu"] = { fg = "#311126", bg = "#f4ede8" },

	["DiagnosticHint"] = { fg = "#907aa9" },
	["DiagnosticInfo"] = { fg = "#56949f" },
	["DiagnosticWarn"] = { fg = "#ea9d34" },
	["DiagnosticError"] = { fg = "#b4637a" },
}
local dark_styles = {
	["Normal"] = { fg = "#e0def4", bg = "#1f1f28" },
	["Statement"] = { fg = "#e0def4", bold = true },
	["Comment"] = { fg = "#908caa", italic = true },
	["String"] = { fg = "#a6e4b2", italic = true },
	["Function"] = { fg = "#ebbcba" },

	["Structure"] = { fg = "#ffafd7" },
	-- ["Identifier"] = { fg = "#9ccfd8" },
	["Special"] = { fg = "#9ccfd8" },
	["Constant"] = { fg = "#eb6f92", italic = true },
	["PreProc"] = { fg = "#9ccfd8", bold = true },
	["type"] = { fg = "#ec8790" },

	["StatusLine"] = { fg = "#f2e9e1", bg = "#6e6a86" },
	["Visual"] = { bg = "#524f67" },
	["ColorColumn"] = { bg = "#2a2a37" },
	["NormalFloat"] = { bg = "#2a2a37" },
	["Pmenu"] = { fg = "#ec8790", bg = "#2a2a37" },

	["DiagnosticHint"] = { fg = "#907aa9" },
	["DiagnosticInfo"] = { fg = "#56949f" },
	["DiagnosticWarn"] = { fg = "#ea9d34" },
	["DiagnosticError"] = { fg = "#b4637a" },
}

if vim.opt.background:get() == "dark" then
	group_styles = dark_styles
end
for group, style in pairs(group_styles) do
	vim.api.nvim_set_hl(0, group, style)
end
