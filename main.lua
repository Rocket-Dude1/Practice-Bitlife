win_w = 600
win_h = 600
function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("Practice Bitlife Game")
  font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/(win_h/10)))
  staticFont = love.graphics.newFont("arial_narrow_7.ttf", 44.4)
  love.graphics.setBackgroundColor(155/255,155/255,155/255)
end