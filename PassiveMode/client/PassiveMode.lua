-- PassiveMode by RockyTV
local allowDamage = true
local attackers = {}

function WeaponDamage(args)
	for id,isPassive in pairs(attackers) do
		if attackers[id] then
			return false
		end
	end
	return allowDamage
end

Events:Subscribe("LocalPlayerExplosionHit", WeaponDamage)
Events:Subscribe("LocalPlayerBulletHit", WeaponDamage)
Events:Subscribe("LocalPlayeForcePulseHit", WeaponDamage)

Network:Subscribe("AllowDamage", function(args) allowDamage = args end)
Network:Subscribe("PassiveTable", function(args) attackers = args end)