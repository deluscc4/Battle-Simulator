-- Dependencies
local utils = require("utils")
local player = require("player.player")
local playerActions = require("player.actions")
local bizarre = require("bizarre.bizarre")

-- Enabling UTF-8 in terminal
utils.enableUtf8()

-- Header
utils.printHeader()

-- Obter definição do jogador
print(string.format("A vida do jogador é %d/%d", player.health, player.maxHealth))

-- Obter definição do monstro
local boss = bizarre

-- Apresentar o monstro
utils.printCreature(boss)

-- Build actions
playerActions.build()

-- Começar o loop de batalha
while true do
    -- Showing actions to the player
    print()
    print("O que você deseja fazer em seguida?")
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil

    -- Simulating player's turn
    if isActionValid then
        chosenAction.execute(player, boss)
    else
        print("Sua ação é inválida. Você tentou algo fora da realidade e perdeu a vez.")
    end

    -- Crature without health
    if boss.health <= 0 then
        break
    end

    -- Player without health
    if player.health <= 0 then
        break
    end
end