cfButtonColors = cfButtonColors or {}
local addon = cfButtonColors

local _, playerClass = UnitClass("player")
addon.isPetClass = (playerClass == "HUNTER" or playerClass == "WARLOCK")

addon.KEYS = {
	PLAYER_MANA  = "PlayerMana",
	PLAYER_RANGE = "PlayerRange",
	PET          = "Pet",
}

addon.DEFAULT_COLORS = {
	manaColor     = {r = 0.55, g = 0.65, b = 1.0},
	rangeColor    = {r = 1.0,  g = 0.65, b = 0.55},
	unusableColor = {r = 0.7,  g = 0.7,  b = 0.7},
}

local defaults = {
	[addon.KEYS.PLAYER_MANA]  = true,
	[addon.KEYS.PLAYER_RANGE] = true,
	[addon.KEYS.PET]          = addon.isPetClass,
	manaColor     = addon.DEFAULT_COLORS.manaColor,
	rangeColor    = addon.DEFAULT_COLORS.rangeColor,
	unusableColor = addon.DEFAULT_COLORS.unusableColor,
}

cfButtonColorsDB = cfButtonColorsDB or {}
for key, value in pairs(defaults) do
	if cfButtonColorsDB[key] == nil then
		if type(value) == "table" then
			cfButtonColorsDB[key] = {r = value.r, g = value.g, b = value.b}
		else
			cfButtonColorsDB[key] = value
		end
	end
end
for key in pairs(cfButtonColorsDB) do
	if defaults[key] == nil then
		cfButtonColorsDB[key] = nil
	end
end

addon.db = cfButtonColorsDB

EventUtil.ContinueOnAddOnLoaded("cfButtonColors", function()
	addon.InitSettings()
	if addon.db[addon.KEYS.PLAYER_MANA]  then addon.EnablePlayerMana()  end
	if addon.db[addon.KEYS.PLAYER_RANGE] then addon.EnablePlayerRange() end
	if addon.db[addon.KEYS.PET] and addon.isPetClass then addon.EnablePet() end
end)
