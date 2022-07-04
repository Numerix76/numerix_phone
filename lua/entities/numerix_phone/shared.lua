--[[ Phone --------------------------------------------------------------------------------------

Phone made by Numerix (https://steamcommunity.com/id/numerix/)

--------------------------------------------------------------------------------------------------]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Phone"
ENT.Category		= "Numerix Scripts"
ENT.Author			= "Numerix"
ENT.Contact			= "https://steamcommunity.com/id/numerix/"
ENT.Purpose			= ""
ENT.Instructions	= ""					
ENT.Spawnable = true

local function RemoveChatCommand()
	if !DarkRP then return end
    DarkRP.removeChatCommand("advert")
end

if (SERVER) then
	hook.Add("PlayerInitialSpawn","Phone:Removecommand",function()
		RemoveChatCommand()
	end)
else
	hook.Add("InitPostEntity","Phone:Removecommand",function()
		RemoveChatCommand()
	end)
end