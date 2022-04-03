
-- luacheck: ignore SLASH_ZULRESETCALCULATOR1
SLASH_ZULRESETCALCULATOR1 = "/zul"

-- luacheck: ignore SLASH_ZULRESETCALCULATOR2
SLASH_ZULRESETCALCULATOR2 = "/zulreset"

-- luacheck: ignore SLASH_ZULRESETCALCULATOR3
SLASH_ZULRESETCALCULATOR3 = "/zulresetcalculator"

-- luacheck: ignore _
-- luacheck: ignore self

local ZulResetCalculator = {};

-- Handler for processing the slash commands
function ZulResetCalculator:Commands(msg)

	-- Parse the first two arguments out of the message
	local _, _, arg1, arg2 = string.find(msg, "%s?(%w+)%s?(.*)")

	-- By default the count will be 3
	local count = 3

	-- By default the channel will be nil
	local channel

	-- Check if the first arg is either a number or a channel
	if type(tonumber(arg1)) == "number" then
		count = tonumber(arg1)
	elseif type(arg1) == "string" then
		channel = arg1
	end

	-- Check if the second arg is either a number or a channel
	if type(tonumber(arg2)) == "number" then
		count = tonumber(arg2)
	elseif type(arg2) == "string" then
		channel = arg2
	end

	ZulResetCalculator.SendToChannel(_, count, channel)

end

function ZulResetCalculator:SendToChannel(count, channel)

	-- Obj used to store channel data
	local channels = {};

	-- Say
	channels['s'] = "SAY"
	channels['say'] = "SAY"
	channels['S'] = "SAY"
	channels["SAY"] = "SAY"

	-- Yell
	channels['y'] = "YELL"
	channels['yell'] = "YELL"
	channels['Y'] = "YELL"
	channels["YELL"] = "YELL"

	-- Raid
	channels['r'] = "RAID"
	channels['raid'] = "RAID"
	channels['R'] = "RAID"
	channels["RAID"] = "RAID"

	-- Guild
	channels['g'] = "GUILD"
	channels['guild'] = "GUILD"
	channels['G'] = "GUILD"
	channels["GUILD"] = "GUILD"

	-- Party
	channels['p'] = "PARTY"
	channels['party'] = "PARTY"
	channels['P'] = "PARTY"
	channels["PARTY"] = "PARTY"

	-- Send the output to the appropriate channel
	local text_output = ZulResetCalculator.GetResets(_, count)
	for i=1,count+1 do
		if channel == nil or channel == "" or channels[channel] == nil then
			print(text_output[i])
		else
			-- luacheck: ignore SendChatMessage
			SendChatMessage(text_output[i], channels[channel])
		end
	end

end

-- Print the raid resets to the chat box
function ZulResetCalculator:GetResets(count)

	-- If count is very large then we will pretend it is not to prevent problems calculating
	-- e.g. the next 2 billion Zul raid resets
	if count > 25 then
		count = 25
	end

	-- 28 March 2022 at 1500 UTC (last reset as of writing)
	local us_epoch = "1648479600"
	-- 28 March 2022 at 0700 UTC (last reset as of writing)
	local eu_epoch = "1648450800"

	-- This will be used to check the region
	-- luacheck: ignore GetCVar
	local region = GetCVar("portal")
	local base_epoch
	-- US, Oceanic, and Latin America servers should all return "US" here
	if region == "US" then
		base_epoch = us_epoch
	elseif region == "EU" then
		-- Checked on retail EU servers and confirmed they return "EU" here
		base_epoch = eu_epoch
	else
		print("An error occured. Unknown game region :" .. region)
		return
	end

	-- Will be used to compare versus base epoch
	-- `time` and `date` are WoW APIs that mirror the lua standard os.time and os.date functions
	-- luacheck: push ignore 113
	local current_unix_epoch = time(date("!*t"))
	-- luacheck: pop

	-- constants for comparison
	local seconds_per_day = 86400
	local seconds_per_reset = seconds_per_day * 3

	-- The raw seconds between now and the original reset
	local time_delta = current_unix_epoch - base_epoch

	-- The last reset is calculated based on how many seconds it has been since the last reset
	local last_reset = current_unix_epoch - (time_delta % seconds_per_reset)

	-- Generate the output
	local text_output = {}
	text_output[1] = "Upcoming Zul Resets:\n"
	for i=1,count do
		-- luacheck: ignore date
		local next_date = date("%c", last_reset + i * seconds_per_reset)
		local chat_string = string.format("Reset #%d: %s\n", i, next_date)
		text_output[i+1] = chat_string
	end

	-- Print the output to the chat box
	return text_output

end

-- Add the slash commands to the client's command list
-- luacheck: ignore SlashCmdList
SlashCmdList["ZULRESETCALCULATOR"] = ZulResetCalculator.Commands
