local addon = cfButtonColors

addon.buttonStates = addon.buttonStates or {}
local buttonStates = addon.buttonStates

function addon.GetButtonState(button)
	if not buttonStates[button] then
		buttonStates[button] = {
			isOutOfMana = false,
			isOutOfRange = false,
			isUnusable = false,
		}
	end
	return buttonStates[button]
end

function addon.ApplyButtonColor(icon, state)
	local db = addon.db
	if state.isOutOfMana then
		local c = db.manaColor
		icon:SetVertexColor(c.r, c.g, c.b)
	elseif state.isOutOfRange then
		local c = db.rangeColor
		icon:SetVertexColor(c.r, c.g, c.b)
	elseif state.isUnusable then
		local c = db.unusableColor
		icon:SetVertexColor(c.r, c.g, c.b)
	else
		icon:SetVertexColor(1, 1, 1)
	end
end

function addon.ResetStateField(field)
	for button, state in pairs(buttonStates) do
		state[field] = false
		if button.icon then addon.ApplyButtonColor(button.icon, state) end
	end
end

function addon.RefreshAllButtons()
	for button, state in pairs(buttonStates) do
		if button.icon then addon.ApplyButtonColor(button.icon, state) end
	end
end
