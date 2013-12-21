-- PassiveMode by RockyTV

function PlayerChat(args)
	
	if args.text == "/passive" then
		
		peaceful[args.player:GetSteamId().id] = not peaceful[args.player:GetSteamId().id]
		
		if peaceful[args.player:GetSteamId().id] then
			args.player:SendChatMessage("[PassiveMode] Passive Mode is now enabled.", color)
			args.player:SendChatMessage("[PassiveMode] While in Passive Mode, you can't attack other players, and the other players can't attack you.", color)
			args.player:SendChatMessage("[PassiveMode] Type /passive to disable Passive Mode.", color)
		else
			args.player:SendChatMessage("[PassiveMode] Passive Mode is now disabled.", color)
			args.player:SendChatMessage("[PassiveMode] Type /passive to enable Passive Mode.", color)
		end
		
		Network:Send(args.player, "AllowDamage", not peaceful[args.player:GetSteamId().id])
		
		for p in Server:GetPlayers() do
			Network:Send(p, "PassiveTable", peaceful)
		end
		
		return false
		
	end
	return true
end

Events:Subscribe("PlayerChat", PlayerChat)