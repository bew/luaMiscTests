--- Goes from "a://foo.bar"  to ("a", "a.foo.bar")
local function transform_module_name(module_name)
  local prefix_delim_idx = module_name:find("://")
  if not prefix_delim_idx then
    return nil, module_name
  end

  local prefix = module_name:sub(0, prefix_delim_idx - 1)
  local full_module_name = prefix .. "." .. module_name:sub(prefix_delim_idx + 3)
  -- print("<<-")
  -- print("prefix:", prefix)
  -- print("full_module_name:", full_module_name)
  -- print("->>")
  return prefix, full_module_name
end

local function get_package_path_additions(prefix_path)
  if prefix_path:sub(1, 1) ~= "/" then
    prefix_path = "./" .. prefix_path
  end
  return ";" .. prefix_path .. "/?.lua;".. prefix_path .. "/?/init.lua"
end

local function read_file(path)
  local file = io.open(path, "r")
  if not file then return nil end
  local content = file:read "*all"
  file:close()
  return content
end

table.insert(package.searchers, 1, function(module_name)
  print()
  print("!! Searcher loading module name", module_name)
  local prefix, full_module_name = transform_module_name(module_name)

  if not prefix then
    -- there is no custom prefix, fallback to the next searchers
    print("!! There is no custom prefix, fallback to the next searchers")
    return
  end

  local filepath = full_module_name:gsub("%.", "/") .. ".lua"
  print("attempting to read:", filepath)
  local file_content = read_file(filepath) -- note: missing file existance check

  local chunk = "package.path = package.path .. '" .. get_package_path_additions(prefix) .. "'"
  chunk = chunk .. "\n" .. file_content
  print()
  print("<<-(patched chunk)")
  print(chunk)
  print("(patched chunk)->>")
  print()
  local func, err = load(chunk, filepath)
  if err then
    return err -- report the error
  end
  return func, full_module_name
end)

require "simple_nesting://main"
