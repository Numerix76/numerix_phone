util.AddNetworkString( "Phone:BuyAdvertAno" )
util.AddNetworkString( "Phone:BuyGouv" )
util.AddNetworkString( "Phone:SendMessage" )
util.AddNetworkString( "Phone:OpenMenu" )

local function CanAccesPhone(ent, ply)

	if !IsValid(ent) and Phone.Settings.GroupeBypass[ply:GetUserGroup()] then return true end

	if !IsValid(ent) then return false end
	if ent:GetClass() != "numerix_phone" then return false end
	if ent:GetPos():DistToSqr(ply:GetPos()) > 22500 then return false end

	ply.phoneentity = nil
	return true
end

local price
net.Receive( "Phone:BuyAdvertAno" , function ( len , ply )
	if ply:IsValid() and ply:Alive() and CanAccesPhone(ply.phoneentity, ply) then
		local text = net.ReadString()
		local ano = net.ReadBool()

		ply.LastMessageAdvert = ply.LastMessageAdvert or 0

		if ply.LastMessageAdvert - CurTime() > 0 then DarkRP.notify( ply, 1, 5, Phone.GetLanguage("You have already sent a message !") ) return end

		ply.LastMessageAdvert = CurTime() + 10

		if ano then
			price = Phone.Settings.PriceDependLenght and Phone.Settings.AnoPrice*string.len(text) or Phone.Settings.AnoPrice
		else
			price = Phone.Settings.PriceDependLenght and Phone.Settings.AdvertPrice*string.len(text) or Phone.Settings.AdvertPrice
		end
		if text == "" then
			DarkRP.notify(ply,1,6, Phone.GetLanguage("Your message is empty !"))
			return
		end
		
		if ply:getDarkRPVar("money") - price < 0 then
			DarkRP.notify( ply, 0, 5, Phone.GetLanguage("You don't have enough money !") )
		else 
			ply:addMoney(-price)
			if ano then
				for k,v in ipairs(player.GetAll()) do 
					if Phone.Settings.GroupeAno[v:GetNWString("usergroup")] then   
						Phone.MakeMessage(v, Phone.Settings.ColorAno,  "["..Phone.GetLanguage("Anonymous").."] ".. ply:Nick() .. " " , Phone.Settings.ColorAnoText, text, ply)
					else
						Phone.MakeMessage(v, Phone.Settings.ColorAno,  "["..Phone.GetLanguage("Anonymous").."] " , Phone.Settings.ColorAnoText, text, ply)
					end
				end
			else
				for k,v in ipairs(player.GetAll()) do
					Phone.MakeMessage(v, Phone.Settings.ColorAdvert,  "["..Phone.GetLanguage("Advert").."] " .. ply:Nick() .. " " , Phone.Settings.ColorAdvertText, text, ply)
				end
			end
		end
	end
end)

net.Receive( "Phone:BuyGouv" , function ( len , ply )
	if ply:IsValid() and ply:Alive() and CanAccesPhone(ply.phoneentity, ply) then 
		local textmessage = net.ReadString()
		price = Phone.Settings.PriceDependLenght and Phone.Settings.GouvPrice*string.len(textmessage) or Phone.Settings.GouvPrice
		
		ply.LastMessageAdvert = ply.LastMessageAdvert or 0

		if ply.LastMessageAdvert - CurTime() > 0 then DarkRP.notify( ply, 1, 5, Phone.GetLanguage("You have already sent a message !") ) return end

		ply.LastMessageAdvert = CurTime() + 10
	
		if textmessage == ""  then
			DarkRP.notify(ply,1,6, Phone.GetLanguage("Your message is empty !"))
			return
		end

		if ply:getDarkRPVar("money") - price < 0 then
			DarkRP.notify( ply, 0, 5, Phone.GetLanguage("You don't have enough money !") )
		else
			Phone.MakeMessage(ply, Phone.Settings.ColorGouv,  Phone.GetLanguage("You have sent to the government").." ", Phone.Settings.ColorGouvText, textmessage, ply)
			ply:addMoney(-price)
			for k,v in ipairs(player.GetAll()) do
				if Phone.Settings.GouvTeam[v:Team()] then   
					Phone.MakeMessage(v, Phone.Settings.ColorGouv, Phone.GetLanguage("Message from").." : ".. ply:Nick().. " " , Phone.Settings.ColorGouvText, textmessage, ply)
				end
			end
		end
	end
end)

function Phone.MakeMessage(receiver, col1, text1, col2, text2, sender)
	if Phone.Settings.MessageChat then
		DarkRP.talkToPerson(receiver, col1, text1, col2, text2, sender)
		return
	end

    if not IsValid(receiver) then return end
    if receiver:IsBot() then return end
    local concatenatedText = (text1 or "") .. ": " .. (text2 or "")

    if sender == receiver or hook.Run("PlayerCanSeePlayersChat", concatenatedText, false, receiver, sender) ~= false then
        net.Start("Phone:SendMessage")
            net.WriteUInt(col1.r, 8)
            net.WriteUInt(col1.g, 8)
            net.WriteUInt(col1.b, 8)
            net.WriteString(text1)

            sender = sender or Entity(0)
            net.WriteEntity(sender)

            col2 = col2 or Color(0, 0, 0)
            net.WriteUInt(col2.r, 8)
            net.WriteUInt(col2.g, 8)
            net.WriteUInt(col2.b, 8)
            net.WriteString(text2 or "")
        net.Send(receiver)
    end
end

hook.Add("PlayerSay", "Intro:PlayerSay", function(ply, text)
    if ply:Alive() and string.sub(text, 1, string.len(Phone.Settings.Command)) == Phone.Settings.Command and Phone.Settings.Command != "" and Phone.Settings.GroupeBypass[ply:GetUserGroup()] then
        net.Start( "Phone:OpenMenu" )
		net.Send( ply )
        return ""
    end
end)