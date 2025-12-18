function ReloadModule(name)
  package.loaded[name] = nil
  return require(name)
end

function _G.filter_keybinds(filter)
  filter = filter or ""
  local function scan_table(tbl, prefix)
    prefix = prefix or ""
    for key, value in pairs(tbl) do
      if type(value) == "table" then
        scan_table(value, prefix .. key)
      elseif type(value) == "string" then
        -- Check if the command matches the filter
        if value:lower():match(filter:lower()) then
          print(prefix .. " -> " .. value)
        end
      elseif type(value) == "table" and value.cmd then
        -- Some WhichKey entries store { cmd = "...", desc = "..." }
        if value.cmd:lower():match(filter:lower()) or (value.desc and value.desc:lower():match(filter:lower())) then
          print(prefix .. " -> " .. value.cmd .. (value.desc and (" (" .. value.desc .. ")") or ""))
        end
      end
    end
  end

  if wk and wk._mappings then
    scan_table(we._mappings)
  else
    print("No WhichKey mappings found.")
  end
end
