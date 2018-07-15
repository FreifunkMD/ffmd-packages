return function(form, uci)
local site = require 'gluon.site'

local notify = uci:get_first("owner", "downtime_notification")

local s = form:section(Section, nil, translate(
	'You may check this option to be notified in case there '
	.. 'are problems with your node, such as being offline '
	.. 'for a certain amount of time.'
))

local o = s:option(Flag, "downtime_notification", translate("Notify on problems with the node"))
o.default = uci:get("owner", notify, "downtime_notification")
o.optional = not site.config_mode.notify.obligatory(false)
-- without a minimal length, an empty string will be accepted even with "optional = false"
o.datatype = "minlength(1)"
function o:write(data)
	uci:set("owner", notify, "downtime_notification", data)
end

return {'owner'}
end
