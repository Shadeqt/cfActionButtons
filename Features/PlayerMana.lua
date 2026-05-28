local addon = cfButtonColors

local enabled
local inited

local function updateUsable(button)
	if not enabled then return end
	if not button.action then return end
	if not HasAction(button.action) then return end

	local state = addon.GetButtonState(button)
	local isUsable, isOutOfMana = IsUsableAction(button.action)
	state.isOutOfMana = isOutOfMana
	state.isUnusable = not isUsable and not isOutOfMana

	addon.ApplyButtonColor(button.icon, state)
end

local function InitPlayerMana()
	if inited then return end
	inited = true
	hooksecurefunc("ActionButton_UpdateUsable", updateUsable)
end

function addon.EnablePlayerMana()
	if enabled then return end
	InitPlayerMana()
	enabled = true
end

function addon.DisablePlayerMana()
	if not enabled then return end
	enabled = false
	addon.ResetStateField("isOutOfMana")
	addon.ResetStateField("isUnusable")
end
