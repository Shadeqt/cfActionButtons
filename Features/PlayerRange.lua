local addon = cfButtonColors

local enabled
local inited

local function updateRange(button)
	if not enabled then return end
	if not button.action then return end
	if not HasAction(button.action) then return end

	local state = addon.GetButtonState(button)
	local isInRange = IsActionInRange(button.action)
	state.isOutOfRange = (isInRange == false or isInRange == 0)

	addon.ApplyButtonColor(button.icon, state)
end

local function InitPlayerRange()
	if inited then return end
	inited = true
	hooksecurefunc("ActionButton_UpdateRangeIndicator", updateRange)
end

function addon.EnablePlayerRange()
	if enabled then return end
	InitPlayerRange()
	enabled = true
end

function addon.DisablePlayerRange()
	if not enabled then return end
	enabled = false
	addon.ResetStateField("isOutOfRange")
end
