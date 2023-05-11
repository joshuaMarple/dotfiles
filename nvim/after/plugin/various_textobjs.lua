local module_checker = require('module_checker')
if not module_checker.IsModuleAvailable('various-textobjs') then
  return
end

-- default config
require("various-textobjs").setup {
	-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
	-- set to 0 to only look in the current line
	lookForwardSmall = 5, 

	-- lines to seek forwards for "big" textobjs (linewise textobjs & url textobj)
	lookForwardBig = 15,

	-- use suggested keymaps (see README)
	useDefaultKeymaps = true, 
}
