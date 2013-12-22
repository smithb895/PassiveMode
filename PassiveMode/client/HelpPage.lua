-- PassiveMode originally by RockyTV https://github.com/RockyTV/PassiveMode
-- Redone by Anzu https://github.com/smithb895/PassiveMode

class 'Passive'

function Passive:__init()
    self.active = true

    Events:Subscribe( "ModuleLoad", self, self.ModulesLoad )
    Events:Subscribe( "ModulesLoad", self, self.ModulesLoad )
    Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end


function Passive:ModulesLoad()
    Events:FireRegisteredEvent( "HelpAddItem",
        {
            name = "Passive/AFK Mode",
            text = 
                "While in Passive Mode, you can't attack other players, and the other players can't attack you.\nYou are still vulnerable to fall damage, though.\n\n" ..
                "Usage: /afk\n or \nUsage: /passive"
        } )
end

function Passive:ModuleUnload()
    Events:FireRegisteredEvent( "HelpRemoveItem",
        {
            name = "Passive/AFK Mode"
        } )
end



local passive = Passive()
