require("config")

data:extend({
  {
    type = "item",
    name = "aquafarm",
    icon = Mod_Name .. "/graphics/icons/aquafarm.png",
    flags = {"goes-to-quickbar"},
    subgroup = "extraction-machine",
	place_result = "aquafarm",
    order = "b[fluids]-a[offshore-pump]-b[aquafarm]",
    stack_size = 10,
  },
})