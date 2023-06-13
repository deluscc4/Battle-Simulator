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
utils.printPlayer(player)
print()
print("vs")
print()

-- Obter definição do monstro
local boss = bizarre
local bossActions = bizarreActions

-- Apresentar o monstro
utils.printCreature(boss)

-- Build actions
playerActions.build()
bizarreActions.build()

local function battleLoop()
    -- Enabling UTF-8 in terminal
utils.enableUtf8()

-- Header
utils.printHeader()

-- Obter definição do jogador
utils.printPlayer(player)
print()
print("vs")
print()

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
        os.execute("cls")
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
end

battleLoop()

while true do
    if player.health <= 0 then
        print()
        print("-----------------------------------------------------------------------")
        print()
        print("Que tristeza! 😭")
        print(string.format("%s não foi capaz de derrotar %s, quem sabe da próxima vez.", player.name, boss.name))
        print()
        print("-----------------------------------------------------------------------")
        print()
        print("Deseja lutar novamente?")
        print("1. Sim")
        print("2. Não")
        local answer = utils.restart()
        if answer == 1 then
            player.health = 10
            boss.health = 10
            player.potions = 3
            battleLoop()
        elseif answer == 2 then
            print()
            print("Obrigado por ter jogado! Hora de descansar no túmulo após a derrota.")
            break
        else
            print("Não é uma opção válida, considerarei o fechamento do jogo. Obrigado por jogar e até mais!")
            break
        end
        
    elseif boss.health <= 0 then
        print()
        print("-----------------------------------------------------------------------")
        print()
        print("TRIUNFO! 😁")
        print(string.format("%s prevaleceu sobre %s! Parabéns pela grande batalha!.", player.name, boss.name))
        print()
        print("-----------------------------------------------------------------------")
        print()
        print("Deseja lutar novamente?")
        print("1. Sim")
        print("2. Não")
        local answer = utils.restart()
        if answer == 1 then
            player.health = 10
            player.potions = 3
            boss.health = 10
            battleLoop()
        elseif answer == 2 then
            print()
            print("Obrigado por ter jogado! Hora de tirar o chapéu de mago e ir descansar com honra.")
            break
        else
            print()
            print("Não é uma opção válida, considerarei o fechamento do jogo. Obrigado por jogar e até mais!")
            break
        end
    end
end