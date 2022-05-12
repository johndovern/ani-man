-- dwmblocks.lua update dwmblocks based on mpv activity

local mp = require 'mp'
local options = require 'mp.options'
local utils = require 'mp.utils'

local o = {
  enabled = "no",
}
options.read_options(o, "ani-man")

function join_paths(...)
    local arg={...}
    path = ""
    for i,v in ipairs(arg) do
        path = utils.join_path(path, tostring(v))
    end
    return path;
end

function set_vars()
    trackPath = mp.get_property_native("path")
end

function update_library()
    os.execute("ani-man -t \"" .. trackPath .. "\"")
end

if o.enabled == "yes" then
    mp.register_event("file-loaded", set_vars)
    mp.register_event("shutdown", update_library)
end
