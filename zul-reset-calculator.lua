
-- Slash commands for the addon
SLASH_ZULRESETCALCULATOR1 = "/zul"
SLASH_ZULRESETCALCULATOR2 = "/zulreset"
SLASH_ZULRESETCALCULATOR3 = "/zulresetcalculator"

-- Handler for processing the slash commands
local function ZulResetCalculator_Commands(msg)
	input = tonumber(msg)
	if type(input) == "number" then
		ZulResetCalculator_PrintResets(input)
	else
		ZulResetCalculator_PrintResets(3)
	end
end

-- Print the raid resets to the chat box
function ZulResetCalculator_PrintResets(count)

	-- If count is very large then we will pretend it is not to prevent problems calculating e.g. the next 2 billion Zul raid resets
	if count > 25 then
		count = 25
	end

	-- 28 March 2022 at 11AM EST (last reset as of writing)
	local base_epoch = "1648479600"

	-- Will be used to compare versus base epoch
	local current_unix_epoch = time(date("!*t"))

	-- constants for comparison
	local seconds_per_day = 86400
	local seconds_per_reset = seconds_per_day * 3

	-- The raw seconds between now and the original reset
	local time_delta = current_unix_epoch - base_epoch

	-- The last reset is calculated based on how many seconds it has been since the last reset
	local last_reset = current_unix_epoch - (time_delta % seconds_per_reset)

	-- Generate the output
	local text_output = ""
	text_output = text_output .. "Upcoming Zul Resets:\n"
	for i=1,count do
		local next_date = date("%c", last_reset + i * seconds_per_reset)
		local chat_string = string.format("Reset #%d: %s\n", i, next_date)
		text_output = text_output .. chat_string
	end

	-- -- Print to chat box
	-- local editbox=ChatEdit_ChooseBoxForSend(DEFAULT_CHAT_FRAME);
	-- editBox:Show()
	-- editBox:SetText(text_output)

	print(text_output)
end

SlashCmdList["ZULRESETCALCULATOR"] = ZulResetCalculator_Commands
