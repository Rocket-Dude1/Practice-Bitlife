--1018 win_w fits perfectly for now
win_w = 1018
win_h = win_w * 0.63

--Returns the x location for text to be centered in the screen
function centeredTextLocation(textLength,textSize)
  return win_w/2 - (12.5*textLength*textSize)
end
--Returns the location for a rectangle to be centered (like a button) in the screen.
function centeredBoxLocation(boxWidth)
  return win_w/2 - (boxWidth/2)
end

-- List of functions that go in buttonFunction()
function gameStart()
  hasGameStart = true
end

--The function that is called when a user presses a button. The command that is run depends on the number.
function buttonFunction(number)
  if number == 1 then
    gameStart()
  elseif number == 2 then
    --Dead button, doesn't do anything---
  end
end

--function which allows you to create buttons the player can press with autosizing text
function button(xLocation,yLocation,width,height,lineWidth,color1,color2,color3,text,textColor,buttonFunctionNumber,hoverEvent)
  love.graphics.setLineWidth(lineWidth)
  love.graphics.setColor(color1/255,color2/255,color3/255)
  love.graphics.rectangle("line",xLocation,yLocation,width,height)
  mouse_x,mouse_y = love.mouse.getPosition()
  if textColor < 100 then
    textColor = 100
  end
  if mouse_x > xLocation and mouse_x < xLocation+width and mouse_y > yLocation and mouse_y < yLocation+height and hoverEvent then
    buttonColor = textColor-100
    if love.mouse.isDown(1) then
      buttonFunction(buttonFunctionNumber)
    end
  else
    buttonColor = textColor
  end
  love.graphics.setColor(buttonColor/255,buttonColor/255,buttonColor/255)
  love.graphics.print(text,staticFont,xLocation+(width/8),yLocation+(height/15),0,width/(#text*34.0136),height*0.0155)
end

--Runs once when the game starts, sets up window and loads any images
function love.load()
  love.window.setMode(win_w, win_h)
  love.window.setTitle (" Better Bitlife Game")
  font = love.graphics.newFont("MonospaceTypewriter.ttf", 48/(80/(win_h/10)))
  staticFont = love.graphics.newFont("MonospaceTypewriter.ttf", 44.4,"normal",30)

  red = 120
  blue = 120
  green = 120
  playButtonColor = 255

  colorUpRed = true
  colorUpGreen = true
  colorUpBlue = true

  hasGameStart = false

  love.graphics.setBackgroundColor(red/255,green/255,blue/255)
  
end
--Updates the game every frame
function love.update(dt)
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
--The function which draws items to the screen every frame.
function love.draw()
  --Sets the basic background
  love.graphics.setColor(70/255,70/255,70/255)
  love.graphics.rectangle("fill",20,20,win_w-40,win_h-40)
  love.graphics.setLineWidth(30)
  love.graphics.rectangle("line",0,0,win_w,win_h)

  --Loads the play button because the player hasn't pressed play yet (obviously)
  if hasGameStart == false then
    love.graphics.setColor(1,1,1)
    love.graphics.print("Better Bitlife",staticFont,centeredTextLocation(14,1),win_h,0,1,1)
    --Play button
    button(centeredBoxLocation(300),(win_h/2)-75,300,150,5,green,red,blue,"PLAY",255,1,true)
  end
  --When the game starts, the rest of the images/buttons load and the player gets to play!
  if hasGameStart == true then
    --Plus 1 button
    button(centeredBoxLocation(230),win_h-260,230,230,5,green,red,blue,"+1",255,2,true)

    --Left title button
    button(30,win_h-260,352,44,5,green,blue,red,"TitleBarHere",255,2,false)
    --Left side buttons
    button(30,win_h-204,170,50,5,green,blue,red,"button1",255,2,true)
    button(30,win_h-142,170,50,5,green,blue,red,"button2",255,2,true)
    button(30,win_h-80,170,50,5,green,blue,red,"button3",255,2,true)
    button(centeredBoxLocation(230)-182,win_h-204,170,50,5,green,blue,red,"button4",255,2,true)
    button(centeredBoxLocation(230)-182,win_h-142,170,50,5,green,blue,red,"button5",255,2,true)
    button(centeredBoxLocation(230)-182,win_h-80,170,50,5,green,blue,red,"button6",255,2,true)

    --Right title button
    button(centeredBoxLocation(230)+242,win_h-260,352,44,5,green,blue,red,"TitleBarHere",255,2,false)
    --Right side buttons
    button(centeredBoxLocation(230)+242,win_h-204,170,50,5,green,blue,red,"button1",255,2,true)
    button(centeredBoxLocation(230)+242,win_h-142,170,50,5,green,blue,red,"button2",255,2,true)
    button(centeredBoxLocation(230)+242,win_h-80,170,50,5,green,blue,red,"button3",255,2,true)
    button(win_w-200,win_h-204,170,50,5,green,blue,red,"button4",255,2,true)
    button(win_w-200,win_h-142,170,50,5,green,blue,red,"button5",255,2,true)
    button(win_w-200,win_h-80,170,50,5,green,blue,red,"button6",255,2,true)
  end
end