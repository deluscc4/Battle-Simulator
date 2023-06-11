-- Dependencies
local player = require("definitions.player")
local bizarre = require("definitions.bizarre")

-- Enabling UTF-8 in terminal
os.execute("chcp 65001")
os.execute("cls")

-- Header
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

-- Obter definição do jogador
print(string.format("A vida do jogador é %d/%d", player.health, player.maxHealth))

-- Obter definição do monstro
local boss = bizarre

-- Apresentar o monstro

-- Começar o loop de batalha