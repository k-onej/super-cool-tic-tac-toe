local game = {}

function game:load()
    self.board = {
        {"b", "b", "b"},
        {"b", "b", "b"},
        {"b", "b", "b"}
    }
    self.cell_size = 128
    self.winner = "none"
    self.tie = false
    self.turn = "o"
end

function game:update(dt)
    if love.keyboard.isDown("r") or love.mouse.isDown(2) then
        self.board = {
            {"b", "b", "b"},
            {"b", "b", "b"},
            {"b", "b", "b"}
        }
        self.winner = "none"
        self.tie = false
        self.turn = "o"
    end

    for i=1,#self.board do
        for j=1,#self.board[i] do
            if love.mouse.getX() > self.cell_size * j and love.mouse.getY() > self.cell_size * i and love.mouse.getX() < self.cell_size * (j + 1) and love.mouse.getY() < self.cell_size * (i + 1) and self.board[i][j] == "b" and self.winner == "none" then
                if love.mouse.isDown(1) and self.turn == "x" then
                    self.board[i][j] = "x"
                    self.turn = "o"
                elseif love.mouse.isDown(1) and self.turn == "o" then
                    self.board[i][j] = "o"
                    self.turn = "x"
                end
            end

            -- yandev eat yo damn heart out
            -- x
            if self.board[i][1] == "x" and self.board[i][2] == "x" and self.board[i][3] == "x" then -- horizontal
                self.winner = "x"
            elseif self.board[1][j] == "x" and self.board[2][j] == "x" and self.board[3][j] == "x" then -- vertical
                self.winner = "x"
            elseif self.board[1][1] == "x" and self.board[2][2] == "x" and self.board[3][3] == "x" then -- diagonal down
                self.winner = "x"
            elseif self.board[1][3] == "x" and self.board[2][2] == "x" and self.board[3][1] == "x" then -- diagonal up
                self.winner = "x"

            -- o
            elseif self.board[i][1] == "o" and self.board[i][2] == "o" and self.board[i][3] == "o" then -- horizontal
                self.winner = "o"
            elseif self.board[1][j] == "o" and self.board[2][j] == "o" and self.board[3][j] == "o" then -- vertical
                self.winner = "o"
            elseif self.board[1][1] == "o" and self.board[2][2] == "o" and self.board[3][3] == "o" then -- diagonal down
                self.winner = "o"
            elseif self.board[1][3] == "o" and self.board[2][2] == "o" and self.board[3][1] == "o" then -- diagonal up
                self.winner = "o"
            
            -- draw
            elseif self:checkTable(self.board[1], "b") and self:checkTable(self.board[2], "b") and self:checkTable(self.board[3], "b") and self.winner == "none" then
                self.tie = true
            end
        end
    end
end

function game:checkTable(tableToCheck, value)
	local doesNotMatch = true
	for k, c in pairs(tableToCheck) do
		if c == value then
			doesNotMatch = false
		end
	end
	return doesNotMatch
end

-- the drawing math here is comical spaghetti but that is simply what happens when u code while ur tired :howitbe:
function game:draw()
    for i=1,2 do
        love.graphics.line(self.cell_size * (i+1), self.cell_size, self.cell_size * (i+1), self.cell_size * 4)
        love.graphics.line(self.cell_size, self.cell_size * (i+1), self.cell_size * 4, self.cell_size * (i+1))
    end

    for i=1,#self.board do
        for j=1,#self.board[i] do
            if self.board[i][j] == "x" then
                love.graphics.line(self.cell_size * (j + 1) - 10, self.cell_size * (i + 1) - 10, self.cell_size * (j + 1) - self.cell_size + 10, self.cell_size * (i + 1) - self.cell_size + 10)
                love.graphics.line(self.cell_size * (j + 1) - self.cell_size + 10, self.cell_size * (i + 1) - 10, self.cell_size * (j + 1) - 10, self.cell_size * (i + 1) - self.cell_size + 10)
            elseif self.board[i][j] == "o" then
                love.graphics.circle("line", self.cell_size * (j + 1) - self.cell_size/2, self.cell_size * (i + 1) - self.cell_size/2, self.cell_size/2 - 10)
            end
        end
    end

    if self.winner == "x" then
        love.graphics.print("x wins!!!", self.cell_size/2, self.cell_size/4, 0, self.cell_size/32)
    elseif self.winner == "o" then
        love.graphics.print("o wins!!!", self.cell_size/2, self.cell_size/4, 0, self.cell_size/32)
    elseif self.tie then
        love.graphics.print("draw", self.cell_size/2, self.cell_size/4, 0, self.cell_size/32)
    else
        if self.turn == "x" then
            love.graphics.print("x's turn", self.cell_size/2, self.cell_size/4, 0, self.cell_size/32)
        elseif self.turn == "o" then
            love.graphics.print("o's turn", self.cell_size/2, self.cell_size/4, 0, self.cell_size/32)
        end
    end
end

function love.load()
    game:load()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end