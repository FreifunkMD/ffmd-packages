if need_table('config_mode', nil, false) and need_table('owner', nil, false) then
  need_boolean('config_mode.owner.obligatory', false)
end
