require("util")
require("config")

---------------------------------------------------------
-- Constants
local aquafarm_radius = 3			-- how far a farm can be from a fish


---------------------------------------------------------
-- Process all ongoing events
function onTick()
	if (game.tick % aquafarm_period == 0) then
		processAquafarms()
	end
end

---------------------------------------------------------
-- Initialize various objects
function onInit()
	global.aquafarms = global.aquafarms or {}
	script.on_event(defines.events.on_tick, onTick)
end
script.on_init(onInit)

---------------------------------------------------------
-- On reload, make sure that processing continues
function onLoad()
	script.on_event(defines.events.on_tick, onTick)
end
script.on_load(onLoad)

---------------------------------------------------------
-- Checks whether this entity is adjacent to water
function nearFish(entity)
	local search_area = {{entity.position.x - aquafarm_radius, entity.position.y - aquafarm_radius}, {entity.position.x + aquafarm_radius, entity.position.y + aquafarm_radius}}
	local fish = entity.surface.find_entities_filtered({type = "fish", area = search_area})
	return #fish > 0
end

---------------------------------------------------------
-- Keep track of built objects
function builtEntity(event)
	local ent = event.created_entity
	local name = ent.name
	local player = nil
	if event.player_index then 
		player = game.players[event.player_index]
	end
	if name == "aquafarm" then
		if nearFish(ent) then
			table.insert(global.aquafarms, ent)
		elseif player then
			player.print({"not-near-fish"})
		end
	end
end
script.on_event(defines.events.on_built_entity, builtEntity)
script.on_event(defines.events.on_robot_built_entity, builtEntity)

---------------------------------------------------------
-- Simulate fishing in aquafarms
function processAquafarms()
	for index, aquafarm in pairs(global.aquafarms) do
		if aquafarm and aquafarm.valid then
			local inventory = aquafarm.get_inventory(defines.inventory.item_main)
			inventory.insert({name = "raw-fish", count = fish_per_second})
			aquafarm.surface.pollute(aquafarm.position, aquafarm_pollution)
		else
			table.remove(global.aquafarms, index)
		end
	end
end

-- Utility function to print all players
function pall(msg)
	for __, player in pairs(game.players) do
		if verbose and player.connected then
			player.print(msg)
		end
	end
end