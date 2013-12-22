-- PassiveMode originally by RockyTV https://github.com/RockyTV/PassiveMode
-- Redone by Anzu https://github.com/smithb895/PassiveMode

allowDamage = true
passives = {}

function WeaponDamage(args)
    if passives[args.attacker:GetSteamId().id] ~= nil or passives[LocalPlayer:GetSteamId().id] ~= nil then
        return false
    end
	return allowDamage
end


function DrawShadowedText( pos, text, colour, size, scale )
    if scale == nil then scale = 1.0 end
    if size == nil then size = TextSize.Default end

    local shadow_colour = Color( 0, 0, 0, colour.a )
    shadow_colour = shadow_colour * 0.4

    Render:DrawText( pos + Vector3( 1, 1, 0 ), text, shadow_colour, size, scale )
    Render:DrawText( pos, text, colour, size, scale )
end

function DrawPassiveTag( playerPos, dist )
	local pos = playerPos + Vector3( 0, 2, 0 )
	local angle = Angle( Camera:GetAngle().yaw, 0, math.pi ) * Angle( math.pi, 0, 0 )

	local text = "(PASSIVE)"
	local text_size = Render:GetTextSize( text, TextSize.Default )

	local t = Transform3()
	t:Translate( pos )
	t:Scale( 0.007 )
    t:Rotate( angle )
    t:Translate( -Vector3( text_size.x, text_size.y, 0 )/2 )

    Render:SetTransform( t )

	local alpha_factor = 255

	--if dist <= 1024 then
	--	alpha_factor = ((math.clamp( dist, 512, 1024 ) - 512)/512) * 255
	--elseif dist >= 3072 then
	--	alpha_factor = (1 - (math.clamp( dist, 3072, 3584 ) - 512)/512) * 255
	--end

	DrawShadowedText( Vector3( 0, 0, 0 ), text, Color( 0, 255, 0, alpha_factor ), TextSize.Default )
end

function RenderTag()
	if Game:GetState() ~= GUIState.Game then return end
	if LocalPlayer:GetWorld() ~= DefaultWorld then return end
    for id,plyObj in pairs(passives) do
		if passives[id] ~= nil then -- If passive, draw tag
            local playerPos = plyObj:GetPosition()
            local dist = playerPos:Distance2D( Camera:GetPosition() )
            if dist < 1000 then
                DrawPassiveTag( playerPos, dist )
            end
		end
	end
end

Events:Subscribe("LocalPlayerExplosionHit", WeaponDamage)
Events:Subscribe("LocalPlayerBulletHit", WeaponDamage)
Events:Subscribe("LocalPlayerForcePulseHit", WeaponDamage)

Network:Subscribe("AllowDamage", function(args) allowDamage = args end)
Network:Subscribe("PassiveTable", function(args) passives = args end)

Events:Subscribe( "Render", RenderTag )


