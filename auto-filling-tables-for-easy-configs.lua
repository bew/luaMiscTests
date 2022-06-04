local new_config_table
new_config_table = function()
  local tbl = {}
  setmetatable(tbl, {
    __index = function(self, key)
      if rawget(self, key) == nil then
        rawset(self, key, new_config_table())
      end
      return rawget(self, key)
    end
  })
  return tbl
end


local cfg = new_config_table()
cfg.foo.bar["weird key"].baz = 3

-- IT WORKS!! \o/
print(cfg.foo.bar["weird key"].baz)
