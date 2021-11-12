win_w = 1000
win_h = win_w * 0.53

function centeredTextLocation(textLength,textSize)
  return win_w/2 - (10*textLength*textSize)
end

function button(xLocation,yLocation,width,height,lineWidth,color1,color2,color3,text,textColor)
  love.graphics.setLineWidth(lineWidth)
  love.graphics.setColor(color1/255,color2/255,color3/255)
  love.graphics.rectangle("line",xLocation,yLocation,width,height)
  love.graphics.setColor(textColor/255,textColor/255,textColor/255)
  love.graphics.print(text,staticFont,xLocation+(width/8),yLocation+(height/4),0,2.05,height*0.017)
end

function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("Practice Bitlife Game")
  font = love.graphics.newFont("MonospaceTypewriter.ttf", 48/(80/(win_h/10)))
  staticFont = love.graphics.newFont("MonospaceTypewriter.ttf", 44.4,"normal",20)

  red = 120
  blue = 120
  green = 120
  playButtonColor = 255

  colorUpRed = true
  colorUpGreen = true
  colorUpBlue = true
  love.graphics.setBackgroundColor(red/255,green/255,blue/255)
  
end

function love.update(dt)
  mouse_x,mouse_y = love.mouse.getPosition()
  if mouse_x > centeredTextLocation(5.48,2) and mouse_y > win_h/2 - 130 and mouse_x < centeredTextLocation(5.48,2) + 220 and mouse_y < win_h/2 - 5 then
    playButtonColor = 155
  else
    playButtonColor = 255
  end
  if love.keyboard.isDown("escape") then
    os.exit()
  end
  if colorUpRed == true then
    red = red + 0.3
  elseif colorUpRed == false then
    red = red - 0.3
  end
  if colorUpBlue == true then
    blue = blue + 0.6
  elseif colorUpBlue == false then
    blue = blue - 0.6
  end
  if colorUpGreen == true then
    green = green + 0.9
  elseif colorUpGreen == false then
    green = green - 0.9
  end
  love.graphics.setBackgroundColor(red/255,green/255,blue/255)
  if red > 220 then
    colorUpRed = false
  elseif red < 120 then
    colorUpRed = true
  end
  if blue > 220 then
    colorUpBlue = false
  elseif blue < 120 then
    colorUpBlue = true
  end
  if green > 220 then
    colorUpGreen = false
  elseif green < 120 then
    colorUpGreen = true
  end
end

function love.draw()
  love.graphics.setColor(70/255,70/255,70/255)
  love.graphics.rectangle("fill",20,20,win_w-40,win_h-40)
  love.graphics.setLineWidth(30)
  love.graphics.rectangle("line",0,0,win_w,win_h)
  
  button(30,30,400,200,7,red,green,blue,"Practice",255)
  button(400,300,300,200,4,red,green,blue,"HEEH",255)
  button(500,30,300,200,4,red,green,blue,"HEEEEH",255)
end