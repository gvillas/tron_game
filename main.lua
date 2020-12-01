

Class = require 'class'

require 'Player'
require 'Map'
-- constantes da janela

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720 

gameState = 'inicio'




function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
        })
    --
    

    love.window.setTitle('TRON')

    --inicializando fontes 
    titleFont = love.graphics.newFont('font.ttf', 64)
    fontePadrao = love.graphics.newFont('comum.ttf', 20)
    --criando jogador1
    player1 = Player(300, 200, 'a', 'd', 'w', 's', 'down', 'space')
    player1Score = 0
    player2 = Player(950, 500, 'left', 'right', 'up', 'down','up', 'l')
    player2Score = 0
    --criando mapa
    map = Map()

    --carregando som
    sons = {['carregar'] = love.audio.newSource('sons/carregar.wav', 'static')}
    music = love.audio.newSource('sons/music.wav', 'static')
    music:setLooping(true)
    music:play()
end
function love.update(dt)
    
    if gameState == 'playing' then
    
        player1:update(dt)
    
        player2:update(dt)

        for i = 1, table.getn(map.vertices), 2 do
            player1:colisao(player1.P[1], player1.P[2], map.vertices[i], map.vertices[i + 1])
        end

        for i = 1, table.getn(map.vertices), 2 do
            player2:colisao(player2.P[1], player2.P[2], map.vertices[i], map.vertices[i + 1])
        end
    end
    if player1.estado == 'morto' then
        gameState = 'waiting'
        player2Score = player2Score + 1
        player1.estado = 'vivo'
        player2.estado = 'vivo'
    elseif player2.estado == 'morto' then
        gameState = 'waiting'
        player1Score = player1Score + 1
        player1.estado = 'vivo'
        player2.estado = 'vivo'
    end
    
end
 
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'inicio' then
            gameState = 'play'
            sons['carregar']:play()
        elseif gameState == 'play' then 
            sons['carregar']:play()
            gameState = 'playing'
        elseif gameState == 'waiting' then
            sons['carregar']:play()
            restart()
            gameState ='play'
        end
    end
end
function love.draw()
    if gameState == 'inicio' then
         --deixa a tela num tom de cinza
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        -- coloca o titulo na pagina
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(titleFont)
        love.graphics.printf('TRON', WINDOW_WIDTH / 2 - 100, 50, WINDOW_HEIGHT / 2)
        -- apertar enter para jogar
        love.graphics.setFont(fontePadrao)
        love.graphics.printf('Press enter', WINDOW_WIDTH / 2 - 60, WINDOW_HEIGHT / 2 + 100, WINDOW_HEIGHT / 2 )
    elseif gameState == 'play' or gameState == 'playing' or gameState == 'waiting' then
        love.graphics.setColor(0, 255, 0)
        player1:render()
        love.graphics.setColor(255, 0, 0)
        player2:render()
        love.graphics.setColor(250, 250, 250)
        map:render()
        displayScore()
        if gameState == 'play' then
            love.graphics.setFont(fontePadrao)
            love.graphics.print('Press enter to start', WINDOW_WIDTH / 2 - 100, WINDOW_HEIGHT / 2 + 100)
        elseif gameState == 'waiting' then
            love.graphics.setFont(fontePadrao)
            love.graphics.print('Press enter to play again',  WINDOW_WIDTH / 2 - 100, WINDOW_HEIGHT / 2 + 100)
        else 
        end
    end
    
end

function displayScore()
    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(titleFont)
    love.graphics.print(tostring(player1Score), 10, 10)
    love.graphics.print(tostring(player2Score), WINDOW_WIDTH - 50, 10)
end

function restart()
    --reiniciando o jogo
        --reiniciando jogador1
	    player1:restart(300, 200, 'down')
        --reiniciando jogador2
        player2:restart(950, 500, 'up')
        --reiniciando mapa
        map:restart()
      
end
