local cbi = require "luci.cbi"
local i18n = require "luci.i18n"
local uci = luci.model.uci.cursor()
local site = require 'gluon.site_config'

local M = {}

function M.section(form)
  local s = form:section(cbi.SimpleSection, nil, i18n.translate(
      'You may chose a period of time after which you will '
      .. 'be notified by an automated e-mail if the node is '
      .. 'offline.'     )
  )

  local o = s:option(cbi.ListValue, "_downtime_notification", i18n.translate("Downtime notification e-mail"))
  o.default = uci:get_first("gluon-node-info", "owner", "downtime_notification", "")
  o.rmempty = not ((site.config_mode or {}).owner or {}).obligatory
  o.datatype = "string"
  o.description = i18n.translate("If activated make sure to put a valid e-mail address in the contact field.")
  o.maxlen = 140

  o:value(nil, i18n.translate('Never send an e-mail for this node'))
  o:value(5, i18n.translate('After a few minutes'))
  o:value(60, i18n.translate('After an hour'))
  o:value(6*60, i18n.translate('After six hours'))
  o:value(24*60, i18n.translate('After a day'))
  o:value(3*24*60, i18n.translate('After three days'))
  o:value(7*24*60, i18n.translate('After a week'))
end

function M.handle(data)
    if data._downtime_notification ~= nil then
      uci:set("gluon-node-info", uci:get_first("gluon-node-info", "owner"), "downtime_notification", data._downtime_notification)
  else
    uci:delete("gluon-node-info", uci:get_first("gluon-node-info", "owner"), "downtime_notification")
  end
  uci:commit("gluon-node-info")
end

return M
