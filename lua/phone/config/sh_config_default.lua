--[[ Phone --------------------------------------------------------------------------------------

Phone made by Numerix (https://steamcommunity.com/id/numerix/)

--------------------------------------------------------------------------------------------------]]

Phone.Settings.VersionDefault = "1.0.4" --DON'T TOUCH THIS

--Change the language
Phone.Settings.Language = "en"

--Send message in the chat ? (if false draw it at the top of the screen)
Phone.Settings.MessageChat = true

--Change the model of the phone
Phone.Settings.Model = "models/props_trainstation/payphone001a.mdl"

--Draw a 3D text above the phone ?
Phone.Settings.ShowName3D = true

--The price of the message depend on the lenght of it ? (Each price will be multiplicate by the number of letter it the message)
Phone.Settings.PriceDependLenght = false

--Price of the ad
Phone.Settings.AdvertPrice = 75

--Price of the ano message
Phone.Settings.AnoPrice = 100

--Activate the gouvernement message ?
Phone.Settings.GouvMessage = true

--Price to contact the government
Phone.Settings.GouvPrice = 50

--Color of "[Anonymous]"
Phone.Settings.ColorAno = Color(0, 0, 0, 255)

--Color of the anonymous message
Phone.Settings.ColorAnoText = Color(255, 255, 0, 255)

--Color of "[Advert]"
Phone.Settings.ColorAdvert = Color(20, 150, 20, 255)

--Colorr of the ad
Phone.Settings.ColorAdvertText = Color(255, 255, 0, 255)

--Color of "Message from Name" et "You have sent to the government :"
Phone.Settings.ColorGouv = Color(20, 150, 20, 255)

--Color of the gorvernment message
Phone.Settings.ColorGouvText = Color(255, 255, 0, 255)

--ULX group that can see the name on an anonymous message
Phone.Settings.GroupeAno = {
	["superadmin"]	= true,
	["admin"]		= true,
}

--ULX group that can open the menu via the command
Phone.Settings.GroupeBypass = {
	["superadmin"] = true,
	["admin"] = true,
}

Phone.Settings.Command = "/phone"

--TEAM that are in governement
timer.Simple(1, function() --DON'T TOUCH
	Phone.Settings.GouvTeam = {
		--[TEAM_POLICE]		= true,
		--[TEAM_CHIEF]		= true,
		--[TEAM_MAYOR]		= true,
	}
end)