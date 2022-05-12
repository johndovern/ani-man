-- dwmblocks.lua update dwmblocks based on mpv activity

local mp = require 'mp'
local options = require 'mp.options'
local utils = require 'mp.utils'

local o = {
  enabled = "no",
}
options.read_options(o, "ani-man")

function set_vars()
  trackPath = mp.get_property_native("path")
end

function ani_scan()
  if os.execute("ani-man -s \"" .. trackPath .. "\"") then
    os.execute("ani-man -t \"" .. trackPath .. "\"")
  end
end

if o.enabled == "yes" then
  mp.register_event("file-loaded", set_vars)
  mp.register_event("file-loaded", ani_scan)
  mp.register_event("shutdown", ani_scan)
end
