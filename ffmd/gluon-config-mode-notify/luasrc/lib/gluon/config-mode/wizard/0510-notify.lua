return function(form, uci)
local site = require 'gluon.site'

local notify = uci:get_first("gluon-node-info", "notify")

local s = form:section(Section, nil, translate(
	'You may check this option to be notified in case there '
	.. 'are problems with your node, such as being offline '
	.. 'for a certain amount of time.'
))

local o = s:option(Flag, "notify", translate("Notify on problems with the node"))
o.default = uci:get("gluon-node-info", notify, "notify")
o.optional = not site.config_mode.notify.obligatory(false)
-- without a minimal length, an empty string will be accepted even with "optional = false"
o.datatype = "minlength(1)"
function o:write(data)
	uci:set("gluon-node-info", notify, "notify", data)
end

return {'gluon-node-info'}
end
