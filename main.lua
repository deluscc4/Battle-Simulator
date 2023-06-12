-- Dependencies
local utils = require("utils")
local player = require("player.player")
local playerActions = require("player.actions")
local bizarre = require("bizarre.bizarre")
local bizarreActions = require("bizarre.actions")

-- Enabling UTF-8 in terminal
utils.enableUtf8()

-- Header
utils.printHeader()

-- Obter definição do jogador
print(string.format("A vida do jogador é %d/%d", player.health, player.maxHealth))

-- Obter definição do monstro
local boss = bizarre
local bossActions = bizarreActions

-- Apresentar o monstro
utils.printCreature(boss)

-- Build actions
playerActions.build()
bizarreActions.build()

-- Começar o loop de batalha
while true do
    -- Showing actions to the player
    print()
    print(string.format("Qual será a próxima ação do %s?", player.name))
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
        print(string.format("Sua escolha é inválida. Você tentou algo fora da realidade e o %s pagou o pato!.", player.name))
    end

    -- Crature without health
    if boss.health <= 0 then
        break
    end

    -- Simulating creature's turn
    print()
    local validBossActions = bossActions.getValidActions(player, boss)
    local bossActions = validBossActions[math.random(#validBossActions)]
    bossActions.execute(player, boss)

    -- Player without health
    if player.health <= 0 then
        break
    end
end

if player.health <= 0 then
    print()
    print("-----------------------------------------------------------------------")
    print()
    print("Que tristeza! 😭")
    print(string.format("%s não foi capaz de derrotar %s, quem sabe da próxima vez.", player.name, boss.name))
    print()
    print("-----------------------------------------------------------------------")
elseif boss.health <= 0 then
    print()
    print("-----------------------------------------------------------------------")
    print()
    print("TRIUNFO! 😁")
    print(string.format("%s prevaleceu sobre %s! Parabéns pela grande batalha!.", player.name, boss.name))
    print()
    print("-----------------------------------------------------------------------")
end