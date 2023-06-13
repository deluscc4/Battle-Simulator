local utils = require("utils")

local actions = {}

actions.list = {}

--- Creates a list of actions which is internally stored
function actions.build()
    -- Resetting list
    actions.list = {}



    -- Attacking creature.
    local dashAttack = {
        description = "Investida afiada.",
        requirement = nil,
        execute = function(playerData, creatureData)
            -- 1. Defining success chance
            local successChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed 
            local success = math.random() <= successChance

            -- 2. Calculating damage
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage))

            -- 3. Printing result
            if success then
                -- Applying damage to the player
                playerData.health = playerData.health - damage

                -- Showing the applied damage 
                print(string.format("%s atacou %s com sucesso e infligiu %d pontos de dano.", creatureData.name, playerData.name, damage))
                
                -- Presenting result
                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                print(string.format("Vida do %s: %s", playerData.name, utils.getProgressBar(healthRate)))
            else
                print(string.format("A investida do %s passou raspando! %s foi mais ráoido!."), creatureData.name, playerData.name)
            end
        end
    }

    local sonarAttack = {
        description = "Ataque sonar.",
        requirement = nil,
        execute = function(playerData, creatureData)
            -- 2. Calculating damage
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage * 0.3))

                -- Applying damage to the player
                playerData.health = playerData.health - damage

                -- Showing the applied damage 
                print(string.format("%s usou um sonar em %s com sucesso e infligiu %d pontos de dano.", creatureData.name, playerData.name, damage))
                
                -- Presenting result
                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                print(string.format("Vida do %s: %s", playerData.name, utils.getProgressBar(healthRate)))
            
        end
    }

    local waitAction = {
        description = "Aguardar.",
        requirement = nil,
        execute = function(playerData, creatureData)
                -- Showing the applied damage 
                print(string.format("%s está analisando o combate e não fez nada esse turno.", creatureData.name))
                
                -- Presenting result
                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
            
        end
    }

    -- Populating list
    actions.list[#actions.list + 1] = dashAttack
    actions.list[#actions.list + 1] = sonarAttack
    actions.list[#actions.list + 1] = waitAction
end

--- Returns a list of valid actions
--- @param playerData table Player definition
--- @param creatureData table Creature definition
--- @return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end

    return validActions
end

return actions