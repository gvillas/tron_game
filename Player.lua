Player = Class{}


function Player:init(x, y, left, right, up, down, direction,boost)
    self.x = x
    self.y = y
    self.height = 8
    self.width = 8
    self.P = {self.x + self.width / 2, self.y}
    self.M = {self.x + self.width / 2, self.y + self.height / 2}
    self.left = left
    self.right = right
    self.up = up
    self.down = down
    self.boost = boost
    self.direction = direction
    self.SPEED = 2
    self.corpo = {self.P[1], self.P[2], self.M[1], self.M[2]}
    --relacionando ao mapa
    self.map = Map(self)
    self.estado ='vivo'
    table.insert(self.map.vertices, self.M[1])
    table.insert(self.map.vertices, self.M[2])
    --carregando sons
    self.sounds = {['morrer'] = love.audio.newSource('sons/morrer.wav', 'static')}
end

   
function Player:update(dt)

 
    if self.direction == 'up' then 
         if love.keyboard.isDown(self.left) then
            self.direction = 'left'
            
         elseif love.keyboard.isDown(self.right) then
            self.direction = 'right'
            
         end
    elseif self.direction == 'left' then
        if love.keyboard.isDown(self.down) then
            self.direction = 'down'
        elseif love.keyboard.isDown(self.up) then
            self.direction = 'up'
        end
    elseif self.direction == 'down' then
        if love.keyboard.isDown(self.left) then
            self.direction = 'left'
        elseif love.keyboard.isDown(self.right) then
            self.direction = 'right'
        end
    elseif self.direction == 'right' then
        if love.keyboard.isDown(self.up) then
            self.direction = 'up'
        elseif love.keyboard.isDown(self.down) then
            self.direction = 'down'
        end
    end
    
    
    if self.estado == 'vivo' then
        if self.direction == 'up' then 
            self.y = self.y - self.SPEED 
            self.P = {self.x + self.width / 2, self.y}
            self.M = {self.x + self.width / 2, self.y + self.height / 2}
            table.insert(self.corpo, self.M[1])
            table.insert(self.corpo, self.M[2])
            table.insert(map.vertices, self.M[1])
            table.insert(map.vertices, self.M[2])
        elseif self.direction == 'down' then
            self.y = self.y + self.SPEED 
            self.P = {self.x + self.width / 2, self.y + self.height}
            self.M = {self.x + self.width / 2, self.y + self.height / 2}
            table.insert(self.corpo, self.M[1])
            table.insert(self.corpo, self.M[2])
            table.insert(map.vertices, self.M[1])
            table.insert(map.vertices, self.M[2])
        elseif self.direction == 'left' then
            self.x = self.x - self.SPEED 
            self.P = {self.x, self.y + self. height / 2}
            self.M = {self.x + self.width / 2, self.y + self.height / 2}
            table.insert(self.corpo, self.M[1])
            table.insert(self.corpo, self.M[2])
            table.insert(map.vertices, self.M[1])
            table.insert(map.vertices, self.M[2])
        elseif self.direction == 'right' then
            self.x = self.x + self.SPEED 
            self.P = {self.x + self.width, self.y + self.height / 2}
            self.M = {self.x + self.width / 2, self.y + self.height / 2}
            table.insert(self.corpo, self.M[1])
            table.insert(self.corpo, self.M[2])
            table.insert(map.vertices, self.M[1])
            table.insert(map.vertices, self.M[2])
        end
    end
    if love.keyboard.isDown(self.boost) then
        self.SPEED = 5
    end

 end
function Player:colisao (px, py, x1, y1)
    local distancia = math.sqrt((px-x1)*(px - x1) + (py - y1)*(py - y1)) 
    if  distancia <= 3 then 
        self.sounds['morrer']:play()
        self.estado = 'morto'
    end
end

function Player:render()
--if self.estado == 'vivo' then
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.line(self.corpo)
  -- end
end
    

function Player:restart(x, y, direction)
	self.x = x
    self.y = y
    self.SPEED = 2
    self.P = {self.x + self.width / 2, self.y}
    self.M = {self.x + self.width / 2, self.y + self.height / 2} 
    self.direction = direction
    self.corpo = {self.P[1], self.P[2], self.M[1], self.M[2]}
    self.estado ='vivo'
    table.insert(self.map.vertices, self.M[1])
    table.insert(self.map.vertices, self.M[2])
end

   