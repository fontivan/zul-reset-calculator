-- luacheck: globals SlashCmdList GetCVar time date print SendChatMessage

local printed = {}
local sent = {}
local region = "US"
local current_epoch = 1648479600 + 123456

SlashCmdList = {}
function GetCVar(name)
	assert(name == "portal")
	return region
end
function time()
	return current_epoch
end
function date(format, epoch)
	if format == "!*t" then
		return {}
	end
	return tostring(epoch)
end
function print(message)
	printed[#printed + 1] = message
end
function SendChatMessage(message, channel)
	sent[#sent + 1] = { message = message, channel = channel }
end

dofile("zul-reset-calculator.lua")

SlashCmdList.ZULRESETCALCULATOR("2")
assert(#printed == 3, "default output should include a heading and two resets")
assert(printed[1] == "Upcoming Zul Resets:\n")
assert(printed[2]:match("^Reset #1: "))
assert(printed[3]:match("^Reset #2: "))

printed = {}
SlashCmdList.ZULRESETCALCULATOR("1 guild")
assert(#sent == 2, "guild output should include a heading and one reset")
assert(sent[1].channel == "GUILD")
assert(sent[2].channel == "GUILD")

sent = {}
SlashCmdList.ZULRESETCALCULATOR("g 1")
assert(#sent == 2, "channel and count should work in either order")
assert(sent[1].channel == "GUILD")
assert(sent[2].channel == "GUILD")

io.write("All tests passed\n")
