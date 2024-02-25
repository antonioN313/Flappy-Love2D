ScoreState = Class{__includes = BaseState}

-- List must be sorted by score to work properly
trophy = {
	['bronze'] = {
		['score'] = 5,
		['img'] = 'images/bronze.png'
	},
	['silver'] = {
		['score'] = 10,
		['img'] = 'images/silver.png'
	},
	['gold'] = {
		['score'] = 20,
		['img'] = 'images/gold.png'
	},
	['diamond'] = {
		['score'] = 40,
		['img'] = 'images/diamond.png'
	}
}

function ScoreState:enter(params)
    self.score = params.score
    self.trophy = nil
	
	for key, value in pairs(trophy) do
		if self.score >= value['score'] then
			self.trophy = value['img']
		end
	end

    if not self.trophy then return end
	
	self.trophy_image = love.graphics.newImage(self.trophy)
	self.trophy_width = 1080
	self.trophy_height = 1080
	self.trophy_scale = 0.2
	self.trophy_x = VIRTUAL_WIDTH / 2 - (self.trophy_width*self.trophy_scale)/2
	self.trophy_y = VIRTUAL_HEIGHT / 2 - (self.trophy_height*self.trophy_scale)/2
end

function ScoreState:update(dt)
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    
    -- Draw trophy in the back
	if self.trophy then
		love.graphics.draw(self.trophy_image, self.trophy_x, self.trophy_y, 0, self.trophy_scale, self.trophy_scale)
	end

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end