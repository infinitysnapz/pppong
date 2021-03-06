require "paddle"
require "ball"
math.randomseed(os.time())
function Clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

function Collide(x1,y1,w1,h1, x2,y2,w2,h2)
    love.graphics.rectangle('fill', x2,y2,w2,h2)
    return x1-w2/2 < x2+w2/2 and
           x2-w1/2 < x1+w1/2 and
           y1-h2/2 < y2+h2/2 and
           y2-h1/2 < y1+h1/2
end

function BCollide(y1,h1,h2)
    return y1-h1/2 < 0 or
           y1+h1/2 > h2
end

function love.load()
    GTime = 0
    Motion = 1.0

    love.graphics.setNewFont(12)
    love.graphics.setColor(255,255,255)
    love.graphics.setBackgroundColor(0,0,0)

    P1 = Paddle(20,love.graphics.getHeight()/2)
    P2 = Paddle(love.graphics.getWidth()-20,love.graphics.getHeight()/2)
    --Ball = Ball(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

    balls = {}
    for i = 1,1,-1 do
        print(i)
        table.insert(balls, Ball(love.graphics.getWidth()/2, love.graphics.getHeight()/2))
    end
end

function love.update(dt)
    dm = dt*Motion
    GTime = GTime + dm

    if love.keyboard.isDown( "up" ) then
        P1:update(-dm)
    elseif love.keyboard.isDown( "down" ) then
        P1:update(dm)
    end
      
    P2:update(dm*math.cos(GTime))
    for i, v in pairs(balls) do
        v:update(dm)
    end
end

function love.draw()
    love.graphics.print('pppong 0.0.9')
    P1:render()
    P2:render()
    for i, v in pairs(balls) do
        v:render()
    end
end

