local h = require('helpers')
local M = {}
M.ab = h.mapper('ia')

M.ab('ir', "if err != nil {}<left>")

M.ab('iferr',
	[[if err != nil {
	<++>
}
]]
)

M.ab('ifelse', [[if <++> {
		<++>
	} else {
		<++>
	}
]])
