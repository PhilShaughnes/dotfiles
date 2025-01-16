--     dBBBBBb.dBBBBP
--         dB'BP          Phil Shaughnessy
--     dBBBP' `BBBBb      https://github.com/philshaughnes
--    dBP        dBP
--   dBP    dBBBBP'

local function load(name)
	-- this resets the lua module cache so we can reload
	package.loaded[name] = nil
	return require(name)
end

load 'settings'
load 'plugin'
load 'keys'
-- load 'abbrev'
load 'augroups'
load 'lsp'
