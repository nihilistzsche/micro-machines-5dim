--Instantiate global table
micro5d = {}
--List of individual mods
micro5d.fivedims = {}

if mods["5dim_core"] then
	if mods["5dim_automation"] then
		micro5d.fivedims.assembler = true
	end
	if mods["5dim_resources"] then
		micro5d.fivedims.furnace = true
	end
	if mods["5dim_mining"] then
		micro5d.fivedims.miner = true
	end
	if mods["5dim_battlefield"] then
		micro5d.fivedims.radar = true
	end
	if mods["5dim_module"] then
		micro5d.fivedims.beacon = true
	end
end
