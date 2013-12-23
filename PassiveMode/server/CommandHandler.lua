-- PassiveMode originally by RockyTV https://github.com/RockyTV/PassiveMode
-- Redone by Anzu https://github.com/smithb895/PassiveMode

function OnPlayerChat(args)
	if args.text == "/passive" or args.text == "/afk" then
		if peaceful[args.player:GetSteamId().id] == nil then
            peaceful[args.player:GetSteamId().id] = args.player
            local allowDamage = false
			args.player:SendChatMessage("[PassiveMode] Passive Mode is now enabled.", color)
			args.player:SendChatMessage("[PassiveMode] While in Passive Mode, you can't attack other players, and the other players can't attack you.", color)
			args.player:SendChatMessage("[PassiveMode] Type /passive to disable Passive Mode.", color)
		else
            peaceful[args.player:GetSteamId().id] = nil
            local allowDamage = true
			args.player:SendChatMessage("[PassiveMode] Passive Mode is now disabled.", color)
			args.player:SendChatMessage("[PassiveMode] Type /passive to enable Passive Mode.", color)
		end
		--Network:Send(args.player, "AllowDamage", allowDamage)
		Network:Broadcast("PassiveTable", peaceful)
		return false
	end
	return true
end

function OnPlayerDeath(args)
    peaceful[args.player:GetSteamId().id] = nil
    --local allowDamage = true
    --Network:Send(args.player, "AllowDamage", allowDamage)
	Network:Broadcast("PassiveTable", peaceful)
end

function OnPlayerJoin(args)
	local next = next
	if next(peaceful) then
		Network:Send(args.player, "PassiveTable", peaceful)
	end
end

function OnPlayerQuit(args)
	peaceful[args.player:GetSteamId().id] = nil
	Network:Broadcast("PassiveTable", peaceful)
end

Events:Subscribe("PlayerChat", OnPlayerChat)
Events:Subscribe("PlayerDeath", OnPlayerDeath)
Events:Subscribe("PlayerJoin", OnPlayerJoin)
Events:Subscribe("PlayerQuit", OnPlayerQuit)