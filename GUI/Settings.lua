local addon = cfButtonColors
local K = addon.KEYS
local F = addon.GUI

function addon.InitSettings()
	local panel = CreateFrame("Frame", "cfButtonColorsSettingsPanel")
	panel.name = "cfButtonColors"
	panel:Hide()

	local title = F.Title(panel, "cfButtonColors")

	local mana = F.Checkbox(panel, title, "Player: mana/usability (blue / grey)", K.PLAYER_MANA, {
		onEnable = addon.EnablePlayerMana, onDisable = addon.DisablePlayerMana,
	})
	local range = F.Checkbox(panel, mana, "Player: range (red)", K.PLAYER_RANGE, {
		onEnable = addon.EnablePlayerRange, onDisable = addon.DisablePlayerRange,
	})
	local pet = F.Checkbox(panel, range, "Pet: range / mana (Hunter and Warlock only)", K.PET, {
		onEnable = addon.EnablePet, onDisable = addon.DisablePet,
		classGate = not addon.isPetClass,
	})

	local manaColor = F.ColorPicker(panel, pet, "Out of mana color", "manaColor", {
		onChange = addon.RefreshAllButtons,
		defaultColor = addon.DEFAULT_COLORS.manaColor,
	})
	local rangeColor = F.ColorPicker(panel, manaColor, "Out of range color", "rangeColor", {
		onChange = addon.RefreshAllButtons,
		defaultColor = addon.DEFAULT_COLORS.rangeColor,
	})
	F.ColorPicker(panel, rangeColor, "Unusable color", "unusableColor", {
		onChange = addon.RefreshAllButtons,
		defaultColor = addon.DEFAULT_COLORS.unusableColor,
	})

	panel:SetScript("OnShow", F.MakeSettingsPanelDraggable)

	local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name, panel.name)
	Settings.RegisterAddOnCategory(category)
end
