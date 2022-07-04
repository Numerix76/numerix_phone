net.Receive( "Phone:SendMessage", function()
	local col1 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))

	local prefixText = net.ReadString()
    local ply = net.ReadEntity()
    ply = IsValid(ply) and ply or LocalPlayer()

    if not IsValid(ply) then return end

    if prefixText == "" or not prefixText then
        prefixText = ply:Nick()
        prefixText = prefixText ~= "" and prefixText or ply:SteamName()
    end

    local col2 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))

    local text = net.ReadString()
    local shouldShow
    if text and text ~= "" then
        if IsValid(ply) then
            shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
        end

        if shouldShow ~= true then
            Phone:AddMessage(col1, prefixText, col2, ": " .. text, 5)
        end
    else
        shouldShow = hook.Call("ChatText", GAMEMODE, "0", prefixText, prefixText, "darkrp")

        if shouldShow ~= true then
            Phone:AddMessage(col1, prefixText, 5)
        end
    end
    chat.PlaySound()
end)


Phone.Message = {}
function Phone:AddMessage(col1, prefixText, col2, text, time)
    table.insert(Phone.Message, #Phone.Message + 1, {
        col1 = col1,
        prefixText = prefixText,
        time = Phone.Message[1] and Phone.Message[1].time + time or CurTime() + time,
        col2 = col2 or Color(255,255,255,255),
        text = text or "",
    })
end

hook.Add("HUDPaint", "Phone:MessageHUD", function()
	if Phone.Message[1] then
        if Phone.Message[1].time > CurTime() then

			surface.SetFont("Phone.ShowMessage")
			local text = Phone.textWrap((Phone.Message[1].prefixText.. "" .. Phone.Message[1].text or ""):gsub("//", "\n"):gsub("\\n", "\n"), "Phone.ShowMessage", ScrW()/2)
			local w, h = surface.GetTextSize(text)
			w = w + 10
			h = h + 10

			draw.RoundedBox(0, ScrW()/2-w/2, 5, w, h, Color(52, 55, 64, 200))

			surface.SetDrawColor( Color( 255, 255, 255, 200 ) )
			surface.DrawOutlinedRect(ScrW()/2-w/2, 5, w, h )
			
			
			draw.DrawNonParsedText(text, "Phone.ShowMessage", ScrW()/2, 10, color_white, 1)
        else
            table.remove(Phone.Message, 1)
        end
    end
end) 