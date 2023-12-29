require("func")
local Data = require("__stdlib__/stdlib/data/data")


if micro.assembler then
	if micro5d.fivedims.assembler then
		microsize5d("assembling-machine", "assembling-machine", "micro-assembler", 10)
	end
end

if micro.furnace then
	if micro5d.fivedims.assembler then
		microsize5d("assembling-machine", "electric-furnace", "micro-furnace", 10)
	end
end
if micro.miner then
	if micro5d.fivedims.miner then
		microsize5d("mining-drill", "electric-mining-drill", "micro-miner", 10)
	end
end

if micro.beacon then
	if micro5d.fivedims.beacon then
		microsize5d("beacon", "beacon", "micro-beacon", 10)
	end
end
if micro.radar then
	if micro5d.fivedims.radar then
		microsize5d("radar", "radar", "micro-radar", 10)
	end
end

require("tech")
