Map = Class {}

function Map:init()
	self.x = 200
	self.y = 100
	self.width = 880
	self.height = 520
	self.vertices = {}
	
	for i = self.x, self.width + 400, 2 do
		table.insert(self.vertices, i)
		table.insert(self.vertices, self.y)
		table.insert(self.vertices, i)
		table.insert(self.vertices, self.y + self.height)
	end
	for j = self.y, self.height + 500, 2  do
		table.insert(self.vertices, self.x)
		table.insert(self.vertices, j)
		table.insert(self.vertices, self.x + self.width)
		table.insert(self.vertices, j)
	end

end


function Map:render()
	 love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

function Map:restart()
	self.vertices = {}
	
	for i = self.x, self.width + 400, 2 do
		table.insert(self.vertices, i)
		table.insert(self.vertices, self.y)
		table.insert(self.vertices, i)
		table.insert(self.vertices, self.y + self.height)
	end
	for j = self.y, self.height + 500, 2 do
		table.insert(self.vertices, self.x)
		table.insert(self.vertices, j)
		table.insert(self.vertices, self.x + self.width)
		table.insert(self.vertices, j)
	end
end
