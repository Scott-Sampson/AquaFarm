require("util")
require("config")

local ent
local name

-- Aquafarm
name = "aquafarm"
ent = util.table.deepcopy(data.raw["container"]["steel-chest"])
ent.name = name
ent.minable.result = name
ent.corpse = "big-remnants"
ent.collision_box = {{-0.7, -0.7}, {0.7, 0.7}}
ent.selection_box = {{-0.9, -0.9}, {0.9, 0.9}}
ent.icon = Mod_Name .. "/graphics/icons/" .. name .. ".png"
ent.picture = 
	{
	  filename = Mod_Name .. "/graphics/entity/" .. name .. "/" .. name .. ".png",
	  width = 76,
	  height = 46,
	  shift = {0.28, 0}
	}
ent.inventory_size = 20
data:extend({ent})