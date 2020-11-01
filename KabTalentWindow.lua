local f = CreateFrame("frame")

f:SetScript("OnEvent", function(self,event,...)
	local hasHeart = C_QuestLog.IsQuestFlaggedCompleted(51211)

	if event == "PLAYER_LOGIN" then
		if hasHeart then
			LoadAddOn("Blizzard_TalentUI")
			LoadAddOn("Blizzard_AzeriteEssenceUI")
		else
			f:SetScript("OnEvent", nil)
			--DisableAddOn("KabTalentWindow","player")
			f:UnregisterEvent("PLAYER_LOGIN")
		end
	end

--[[ local RequestTome;
do
	local tomes = {
		143780, -- Tome of the Tranquil Mind
		143785, -- Tome of the Tranquil Mind
		141446, -- Tome of the Tranquil Mind
		153647, -- Tome of the Quiet Mind
	};
	local function GetBestTome()
		if UnitLevel("player") <= 109 then -- Tome of the Clear Mind (WOD)
			local itemId = 141640
			local count = GetItemCount(itemId);
			if count >= 1 then
				local name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(itemId);
				return itemId, name, link, quality, icon;
			end
		end
		for _,itemId in ipairs(tomes) do
			local count = GetItemCount(itemId);
			if count >= 1 then
				local name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(itemId);
				return itemId, name, link, quality, icon;
			end
		end
	end
	function RequestTome()
			local itemId, name, link, quality, icon = GetBestTome();
			print (itemId, name)
			UseItemByName (name,"player")
			if name ~= nil then
				local r, g, b = GetItemQualityColor(quality or 2);
			elseif itemId == nil then
			end
	end
end --]]

	local function aeshow()
		if not InCombatLockdown() then
			if CharacterFrame:IsVisible() then HideUIPanel(CharacterFrame) end
			--if AzeriteEssenceUI:IsVisible() then HideUIPanel(AzeriteEssenceUI) else ShowUIPanel(AzeriteEssenceUI) end
			ShowUIPanel(AzeriteEssenceUI)
			PlayerTalentFrameTab2:Click()

			local btn = CreateFrame("Button", "myButton", PlayerTalentFrame, "SecureActionButtonTemplate");
			btn:SetAttribute("type", "item")
--
			btn:SetAttribute("item", "Tome of the Tranquil Mind")
			--btn:SetAttribute("item", "Tome of the Quiet Mind")
--
			btn:SetNormalTexture("134915")
			btn:SetPushedTexture("134916")
			btn:SetSize(20,20)
			btn:SetText("Use Tome")
			btn:SetPoint("BOTTOMRIGHT",-6,4)
			btn:Show()
		end
	end

	local function aehide()
		if not InCombatLockdown() then
			if AzeriteEssenceUI:IsVisible() then HideUIPanel(AzeriteEssenceUI) end
			--if PlayerTalentFrame:IsVisible() then HideUIPanel(PlayerTalentFrame) end
		end
	end

	if hasHeart then
		PlayerTalentFrame:HookScript("OnShow",function(self) aeshow() end)
		PlayerTalentFrame:HookScript("OnHide",function(self) aehide() end)
		AzeriteEssenceUI:HookScript("OnHide",function(self) aehide() end)
	end

end)

f:RegisterEvent("PLAYER_LOGIN")