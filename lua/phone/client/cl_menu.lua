local colorline_frame = Color( 255, 255, 255, 100 )
local colorbg_frame = Color(52, 55, 64, 200)

local colorline_button = Color( 255, 255, 255, 100 )
local colorbg_button = Color(33, 31, 35, 200)
local color_hover = Color(0, 0, 0, 100)

local color_text = Color(255,255,255,255)

net.Receive( "Phone:OpenMenu", function() 
	
	if !Phone.Settings.GouvMessage then Phone.OpenAdvertPanel() return end
	
	local TelephoneBase = vgui.Create( "DFrame" )
	TelephoneBase:SetSize(325, 325)
	TelephoneBase:Center()
	TelephoneBase:MakePopup()
	TelephoneBase:SetDraggable( false ) 
	TelephoneBase:ShowCloseButton( false ) 
	TelephoneBase:SetTitle( " " )
	TelephoneBase.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, colorbg_frame )
		surface.SetDrawColor( colorline_frame )
        surface.DrawOutlinedRect( 0, 0, w , h )
	end

	local TelephoneDesc = vgui.Create( "DLabel", TelephoneBase )
	TelephoneDesc:SetPos( 0,15 )
	TelephoneDesc:SetSize(TelephoneBase:GetWide(), 100)
	TelephoneDesc:SetText( Phone.GetLanguage("What do you want to do ?") )
	TelephoneDesc:SetFont( "Phone.Text1" )
	TelephoneDesc:SetContentAlignment(5)

	local Close = vgui.Create( "DButton", TelephoneBase )		
	Close:SetPos( TelephoneBase:GetWide() - 30, 5 )
	Close:SetText( "X" )
	Close:SetTextColor( color_text )
	Close:SetSize( 25, 25 )
	Close.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	Close.DoClick = function()
		TelephoneBase:Close()
	end

	local BouttonAdvert = vgui.Create( "DButton", TelephoneBase )		
	BouttonAdvert:SetPos( 62.5, 130 )
	BouttonAdvert:SetText( Phone.GetLanguage("Post an ad") )
	BouttonAdvert:SetTextColor( color_text )
	BouttonAdvert:SetSize( 200, 40 )
	BouttonAdvert.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	BouttonAdvert.DoClick = function()
		TelephoneBase:Close()
		Phone.OpenAdvertPanel()
	end

	local BouttonGouv = vgui.Create( "DButton", TelephoneBase )		
	BouttonGouv:SetPos( 62.5, 200 )
	BouttonGouv:SetText( Phone.GetLanguage("Contact the government") )
	BouttonGouv:SetTextColor( color_text )
	BouttonGouv:SetSize( 200, 40 )
	BouttonGouv.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	BouttonGouv.DoClick = function()
		TelephoneBase:Close()
		Phone.OpenGouvPanel()
	end
end)


function Phone.OpenAdvertPanel()
	local PanelAnnonce = vgui.Create( "DFrame" )
	PanelAnnonce:SetSize(325, 325)
	PanelAnnonce:Center()
	PanelAnnonce:MakePopup()
	PanelAnnonce:SetDraggable( false ) 
	PanelAnnonce:ShowCloseButton( false ) 
	PanelAnnonce:SetTitle( " " )
	PanelAnnonce.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, colorbg_frame )
		surface.SetDrawColor( colorline_frame )
        surface.DrawOutlinedRect( 0, 0, w , h )
	end

	local Close = vgui.Create( "DButton",PanelAnnonce )		
	Close:SetPos( PanelAnnonce:GetWide() - 30, 5 )
	Close:SetText( "X" )
	Close:SetTextColor( Color( 255, 255, 255, 255 ) )
	Close:SetSize( 25, 25 )
	Close.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	Close.DoClick = function()
		PanelAnnonce:Close()
	end

	local TextEntryAnnonce = vgui.Create( "DTextEntry", PanelAnnonce )
	TextEntryAnnonce:SetPos( 50, 100 )
	TextEntryAnnonce:SetSize( 220, 35 )

	local CheckBoxAno = vgui.Create( "DCheckBox", PanelAnnonce)
	CheckBoxAno:SetPos( 50, 160 )
	CheckBoxAno:SetValue( 0 )

	local AnoText = vgui.Create( "DLabel", PanelAnnonce )
	AnoText:SetPos( 75,157 )
	AnoText:SetSize(200, 20)
	AnoText:SetText( Phone.GetLanguage("Anonymous message") )

	local BouttonSend = vgui.Create( "DButton",PanelAnnonce )		
	BouttonSend:SetPos( 52.5, 200 )
	BouttonSend:SetText( Phone.GetLanguage("Broadcast the ad").." ("..(Phone.Settings.PriceDependLenght and 0 or Phone.Settings.AdvertPrice).."$)." )
	BouttonSend:SetTextColor( color_text )
	BouttonSend:SetSize( 220, 40 )
	BouttonSend.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	BouttonSend.DoClick = function()
		net.Start("Phone:BuyAdvertAno")
		net.WriteString(TextEntryAnnonce:GetValue())
		net.WriteBool( CheckBoxAno:GetChecked() )
		net.SendToServer()

		PanelAnnonce:Close()
	end

	local text
	function TextEntryAnnonce:OnChange()
		if Phone.Settings.PriceDependLenght then
			text = !CheckBoxAno:GetChecked() and Phone.GetLanguage("Broadcast the ad").." ("..Phone.Settings.AdvertPrice*string.len(self:GetValue()).."$)." or Phone.GetLanguage("Broadcast the anonymous message").." ("..Phone.Settings.AnoPrice*string.len(self:GetValue()).."$)."
			BouttonSend:SetText(text)
		end
	end

	function CheckBoxAno:OnChange( val )
		if Phone.Settings.PriceDependLenght then
			if val == false then
				BouttonSend:SetText( Phone.GetLanguage("Broadcast the ad").." ("..Phone.Settings.AdvertPrice*string.len(TextEntryAnnonce:GetValue()).."$)." )
			else
				BouttonSend:SetText( Phone.GetLanguage("Broadcast the anonymous message").." ("..Phone.Settings.AnoPrice*string.len(TextEntryAnnonce:GetValue()).."$)." )
			end
		else
			if val == false then
				BouttonSend:SetText( Phone.GetLanguage("Broadcast the ad").." ("..Phone.Settings.AdvertPrice.."$)." )
			else
				BouttonSend:SetText( Phone.GetLanguage("Broadcast the anonymous message").." ("..Phone.Settings.AnoPrice.."$)." )
			end
		end
	end
end


function Phone.OpenGouvPanel()
	local PanelGouv = vgui.Create( "DFrame" )
	PanelGouv:SetSize(325, 325)
	PanelGouv:Center()
	PanelGouv:MakePopup()
	PanelGouv:SetDraggable( false ) 
	PanelGouv:ShowCloseButton( false ) 
	PanelGouv:SetTitle( " " )
	PanelGouv.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, colorbg_frame )
		surface.SetDrawColor( colorline_frame )
        surface.DrawOutlinedRect( 0, 0, w , h )
	end

	local Close = vgui.Create( "DButton",PanelGouv )		
	Close:SetPos( PanelGouv:GetWide() - 30, 5 )
	Close:SetText( "X" )
	Close:SetTextColor( color_text )
	Close:SetSize( 25, 25 )
	Close.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	Close.DoClick = function()
		PanelGouv:Close()
	end

	local GouvernementAttention = vgui.Create( "DLabel", PanelGouv )
	GouvernementAttention:SetPos( 25,50 )
	GouvernementAttention:SetSize(300, 100)
	GouvernementAttention:SetText( Phone.GetLanguage("Gouvernment information") )
	GouvernementAttention:SetFont("Phone.Text2")

	local TextEntryMessage = vgui.Create( "DTextEntry", PanelGouv )
	TextEntryMessage:SetPos( 50, 150 )
	TextEntryMessage:SetSize( 220, 35 )

	local BouttonSend = vgui.Create( "DButton", PanelGouv )		
	BouttonSend:SetPos( 52.5, 200 )
	BouttonSend:SetText( Phone.GetLanguage("Send the message").." ("..(Phone.Settings.PriceDependLenght and 0 or Phone.Settings.GouvPrice).."$)." )
	BouttonSend:SetTextColor( color_text )
	BouttonSend:SetSize( 220, 40 )
	BouttonSend.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, colorbg_button)

		surface.SetDrawColor( colorline_button )
		surface.DrawOutlinedRect( 0, 0, w, h )

		if self:IsHovered() or self:IsDown() then
			draw.RoundedBox( 0, 0, 0, w, h, color_hover )
		end
	end
	BouttonSend.DoClick = function()
		net.Start("Phone:BuyGouv")
		net.WriteString(TextEntryMessage:GetValue())
		net.SendToServer()	

		PanelGouv:Close()
	end

	function TextEntryMessage:OnChange()
		if Phone.Settings.PriceDependLenght then
			BouttonSend:SetText(Phone.GetLanguage("Send the message").." ("..Phone.Settings.GouvPrice*string.len(self:GetValue()).."$).")
		end
	end

end