--Data contains all functions contained in the Factorio stdlib
local Data = require("__stdlib__/stdlib/data/data")
local Recipe = require("__stdlib__/stdlib/data/recipe")
require("__micro-machines__/func")
--Instantiates the entire set of item, recipe, and entity for micro machine.
--	entityType	= string; type of entity e.g. "assembling-machine"
--	entityBase	= string; machine name minus tier e.g. "oil-refinery"
--	entitymicro	= string; name for micro machine set minus tier e.g. "micro-refinery"
--	maxTier		= int; max tier in set of machines (defined in final-fixes based on modlist)
function microsize5d(entityType, entityBase, entitymicro, maxTier)
	for n = 1, maxTier do
		--Set name of the current and next tier
		local baseCurrent = entityBase .. "-" .. n
		local basePrev = entityBase .. "-" .. (n - 1)
		local microCurrent = entitymicro .. "-" .. n
		local microNext = entitymicro .. "-" .. (n + 1)
		local microPrev = entitymicro .. "-" .. (n - 1)
		local values = {}

		--Special handling for 5dims machines
		if micro5d.fivedims then
			if micro5d.fivedims.assembler and string.match(entitymicro, "assembler") and n > 3 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.refinery and string.match(entitymicro, "refinery") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.chemplant and string.match(entitymicro, "chemplant") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.furnace and string.match(entitymicro, "furnace") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.miner and string.match(entitymicro, "miner") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.tank and string.match(entitymicro, "tank") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.radar and string.match(entitymicro, "radar") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
			if micro5d.fivedims.beacon and string.match(entitymicro, "beacon") and n > 1 then
				baseCurrent = "5d-" .. entityBase .. "-0" .. n
				basePrev = "5d-" .. entityBase .. "-0" .. (n - 1)
				if n == 10 then
					baseCurrent = "5d-" .. entityBase .. "-" .. n
				end
			end
		end

		if not Data(baseCurrent, "item"):is_valid() then
			baseCurrent = entityBase
		end
		if n > 1 and not Data(basePrev, "item"):is_valid() then
			basePrev = entityBase
		end

		--Copy the item, recipe, and entity data of baseCurrent and name as microCurrent
		Data(baseCurrent, "item"):copy(microCurrent)
		Data(baseCurrent, "recipe"):copy(microCurrent)
		Data(baseCurrent, entityType):copy(microCurrent)

		--Fixes upgrade from previous machine
		Recipe(microCurrent):replace_ingredient(basePrev, microPrev)

		--Fixes results for current machine
		Recipe(microCurrent):replace_results(baseCurrent, microCurrent)

		--Base machine field is used later by tech.lua to trace originating technology
		if Data(microCurrent, "recipe"):get_field("base_machine") then
			Data(microCurrent, "recipe"):set_field("base_machine")
		else
			Data(microCurrent, "recipe"):set_field("base_machine", baseCurrent)
		end

		--Shrinks down the entity itself
		if string.match(entitymicro, "refinery") then
			--Refinery not implemented
			Data(microCurrent, entityType):rescale_entity((3 / 5))
		else
			Data(microCurrent, entityType):rescale_entity((1 / 3))
		end

		--Apply balance changes to recipe
		Data(microCurrent, "recipe"):balanceRecipe()

		--Fixes the pipe connection positions
		Data(microCurrent, entityType):fixPipeConnections()
		Data(microCurrent, entityType):fixHeatConnections()

		--Properly sets the next_upgrade target, if one should exist
		if Data(microCurrent, entityType):get_field("next_upgrade") then
			Data(microCurrent, entityType):set_field("next_upgrade", microNext)
		end

		--Force main_product field, in case of Amator's mods
		Recipe(microCurrent):set_main_product(microCurrent, microCurrent, microCurrent)

		--
		Data(microCurrent, "item"):reorder()
		Data(microCurrent, "item"):fixIcon()
		Data(microCurrent, "recipe"):fixIcon()
		Data(microCurrent, entityType):fixIcon()
		Data(microCurrent, entityType):set_field("scale_entity_info_icon", true)
		Data(microCurrent, entityType):set_field("entity_info_icon_shift", { 0, -0.1 })
	end
end
