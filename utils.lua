local utils = {}

---
--- This function enables UTF-8 in terminal.
---
function utils.enableUtf8()
    os.execute("chcp 65001")
    os.execute("cls")
end

---
--- This function prints the header.
---
function utils.printHeader()
    print([[
=======================================================================

                      /()
                     / /
                    / /
      /============| |------------------------------------------,
    {=| / / / / / /|()}     }     }     }                        >
      \============| |------------------------------------------'
                    \ \
                     \ \
                      \()

                        ---------------------------

                        ⚔️  SIMULADOR DE BATALHA ⚔️            

=======================================================================
            Você empunha seu artefato e se prepara para lutar.
                         É hora da batalha!
]])
end

---
---@param attribute number A number from 0 to 10.
---@return string
---
function utils.getProgressBar(attribute)
    local fullChar = "▰"
    local emptyChar = "▱"
    local result = ""

    for i = 1, 10, 1 do
        result = result .. (i <= attribute and fullChar or emptyChar)
    end

    return result
end

---
--- Printing creature information
--- @param creature table
---
function utils.printCreature(creature)
    -- Calculating health rate
    local healthRate = math.floor((creature.health / creature.maxHealth) * 10)

    -- Creature card
    print("| " .. creature.name)
    print("| ")
    print("| " .. creature.description)
    print("| ")
    print("| Atributos")
    print("|    Ataque:       " .. utils.getProgressBar(creature.attack))
    print("|    Defesa:       " .. utils.getProgressBar(creature.defense))
    print("|    Velocidade:   " .. utils.getProgressBar(creature.speed))
    print("|    Vida:         " .. utils.getProgressBar(healthRate))
end

---
--- Printing player information
--- @param player table
---
function utils.printPlayer(player)
    -- Calculating health rate
    local healthRate = math.floor((player.health / player.maxHealth) * 10)

    -- Creature card
    print("| " .. player.name .. " (Você)")
    print("| ")
    print("| " .. player.description)
    print("| ")
    print("| Atributos")
    print("|    Ataque:       " .. utils.getProgressBar(player.attack))
    print("|    Defesa:       " .. utils.getProgressBar(player.defense))
    print("|    Velocidade:   " .. utils.getProgressBar(player.speed))
    print("|    Vida:         " .. utils.getProgressBar(healthRate))
end

--- Asks an input which is returned
---@return number
function utils.ask()
    io.write("> ")
    local answer = io.read("*n")
    return answer
end

return utils