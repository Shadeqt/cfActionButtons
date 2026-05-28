local addon = cfButtonColors

local NUM_SLOTS = NUM_PET_ACTION_SLOTS
local enabled
local inited

local function updatePetButtons()
	if not enabled then return end
	if not PetHasActionBar() then return end

	for i = 1, NUM_SLOTS do
		local button = _G["PetActionButton" .. i]
		if button and button.icon then
			local _, _, _, _, _, _, spellId, hasRangeCheck, isInRange = GetPetActionInfo(i)
			if spellId then
				local state = addon.GetButtonState(button)
				local isUsable, isOutOfMana = C_Spell.IsSpellUsable(spellId)
				state.isOutOfMana = isOutOfMana
				state.isOutOfRange = hasRangeCheck and (isInRange == false or isInRange == 0)
				state.isUnusable = not isUsable and not isOutOfMana
				addon.ApplyButtonColor(button.icon, state)
			end
		end
	end
end

local function resetPetButtons()
	for i = 1, NUM_SLOTS do
		local button = _G["PetActionButton" .. i]
		if button and button.icon then
			button.icon:SetVertexColor(1, 1, 1)
		end
	end
end

local function InitPet()
	if inited then return end
	inited = true

	hooksecurefunc("PetActionBar_Update", function()
		if not enabled then return end
		updatePetButtons()
	end)

	C_Timer.NewTicker(0.2, function()
		if not enabled then return end
		if PetHasActionBar() and (UnitCanAttack("player", "target") or UnitPower("pet") < UnitPowerMax("pet")) then
			updatePetButtons()
		end
	end)
end

function addon.EnablePet()
	if not addon.isPetClass then return end
	if enabled then return end
	InitPet()
	enabled = true
end

function addon.DisablePet()
	if not enabled then return end
	enabled = false
	resetPetButtons()
end
