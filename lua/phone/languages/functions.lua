--[[ Phone --------------------------------------------------------------------------------------

Phone made by Numerix (https://steamcommunity.com/id/numerix/)

--------------------------------------------------------------------------------------------------]]

function Phone.GetLanguage(sentence)
	if Phone.Language[Phone.Settings.Language] and Phone.Language[Phone.Settings.Language][sentence] then
        return Phone.Language[Phone.Settings.Language][sentence]
    else
        return Phone.Language["default"][sentence]
    end
end

local PLAYER = FindMetaTable("Player")

function PLAYER:PhoneChatInfo(msg, type)
    if SERVER then
        if type == 1 then
            self:SendLua("chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 0, 165, 225 ), [["..msg.."]])")
        elseif type == 2 then
            self:SendLua("chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 180, 225, 197 ), [["..msg.."]])")
        else
            self:SendLua("chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 225, 20, 30 ), [["..msg.."]])")
        end
    end

    if CLIENT then
        if type == 1 then
            chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 0, 165, 225 ), msg)
        elseif type == 2 then
            chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 180, 225, 197 ), msg)
        else
            chat.AddText(Color( 225, 20, 30 ), [[[Phone] : ]] , Color( 225, 20, 30 ), msg)
        end
    end
end