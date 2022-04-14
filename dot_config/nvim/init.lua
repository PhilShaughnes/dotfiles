--		 dBBBBBb.dBBBBP
--				 dB'BP					Phil Shaughnessy
--		 dBBBP' `BBBBb			https://github.com/philshaughnes
--		dBP        dBP
--	 dBP    dBBBBP'


local function load(name)
	-- this resets the lua module cache so we can reload
	package.loaded[name] = nil
	return require(name)
end

load 'helpers'
load 'settings'
load 'plugins'
load 'keys'
load 'augroups'
load 'config/cmp_config'
load 'config/lsp_config'

vim.cmd('colorscheme sonokai')
