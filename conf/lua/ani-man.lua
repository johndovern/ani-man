-- dwmblocks.lua update dwmblocks based on mpv activity

local mp = require 'mp'
local options = require 'mp.options'

local o = {
  enabled = "no",
}
options.read_options(o, "ani-man")

local function ani_scan()
  local trackPath = mp.get_property_native("path")
  if os.execute("ani-man -s \"" .. trackPath .. "\"") then
    os.execute("ani-man -t \"" .. trackPath .. "\"")
  end
end

if o.enabled == "yes" then
  mp.register_event("file-loaded", ani_scan)
end
