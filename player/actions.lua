local utils = require("utils")

local actions = {}

actions.list = {}

--- Creates a list of actions which is internally stored
function actions.build()
    -- Resetting list
    actions.list = {}

    -- Attacking creature.
    local bastionAttack = {
        description = "Lançar feitiço com o cajado.",
        requirement = nil,
        execute = function(playerData, creatureData)
            -- 1. Defining success chance
            local successChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed 
            local success = math.random() <= successChance

            -- 2. Calculating damage
            local rawDamage = playerData.attack - math.random() * creatureData.defense
            local damage = math.max(1, math.ceil(rawDamage))

            -- 3. Printing result
            if success then
                -- Applying damage to the creature
                creatureData.health = creatureData.health - damage
                print()
                -- Showing the applied damage 
                print(string.format("%s atacou com sucesso e infligiu %d pontos de dano.", playerData.name, damage))
                
                -- Presenting result
                local healthRate = math.floor((creatureData.health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgressBar(healthRate)))
            else
                print()
                print("A magia passou raspando! Mais sorte da próxima vez.")
                local healthRate = math.floor((creatureData.health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgressBar(healthRate)))
            end
        end
    }

    local regenPotion = {
        description = "Tomar uma poção de regeneração.",
        requirement = function(playerData, creatureData)
            return playerData.potions >= 1
        end,

        execute = function(playerData, creatureData)
            -- Taking off potions from the player's inventory
            playerData.potions = playerData.potions - 1
            print()
            -- Regenerating health
            local regenPoints = 10
            playerData.health = math.min(playerData.maxHealth, playerData.health + regenPoints)
            print(string.format("%s usou a poção da vitalidade e recuperou sua vida ao máximo. %s tem mais %d poções.", playerData.name, playerData.name, playerData.potions))
        end
    }

    -- Populating list
    actions.list[#actions.list + 1] = bastionAttack
    actions.list[#actions.list + 1] = regenPotion
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