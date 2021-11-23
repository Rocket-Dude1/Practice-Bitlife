--1018 win_w fits perfectly for now
win_w = 1018
win_h = win_w * 0.7
--Makes sure events will be random
math.randomseed(os.time())

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
  pressed = false

  colorUpRed = true
  colorUpGreen = true
  colorUpBlue = true
  name = ""
  gender = ""
  validKeys = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","space"}

  hasGameStart = false
  characterCreated = false
  characterNamed = false
  roundCompleted = false
  nameBoxSelected = false

  love.graphics.setBackgroundColor(red/255,green/255,blue/255)

  age = 1
  outcomeLoaded = false
  choiceStory = false
  choiceTime = true
  initialLoad = false
  randomStory = -1
  previousStory = -1
  outcome = 1
end

function enterName()
  if nameBoxSelected == true then
    button(centeredBoxLocation(500),(win_h/4)-75,500,70,5,green,red,blue,name,255,6,false,false,true)
    function love.keypressed(key)
      if key == "backspace" then
        name = string.sub(name,0,(#name-1))
      elseif key == "return" then
        nameBoxSelected = false
      elseif #name <= 15 and inList(key,validKeys) then
        if key == "space" then
          name = name .. " "
        else
          name = name .. string.upper(key)
        end
      end
    end
  elseif nameBoxSelected == false then
    button(centeredBoxLocation(500),(win_h/4)-75,500,70,5,40,40,40,name,255,6,true,true,true)
    function love.keypressed(key)
      --Empty to reset the love.keypressed function
    end
  end
end

--Updates the game every frame
function love.update(dt)
  --Quits the program if the player presses escape at any time
  if love.keyboard.isDown("escape") then
    os.exit()
  end
  --For all button functions that should only execute once----as soon as the user isn't pressing the mouse the button pressed resets
  if love.mouse.isDown(1) == false then
    pressed = false
  end


  --Changing colors
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
  love.graphics.setBackgroundColor(red/255,green/255,blue/255)


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
    love.graphics.setColor(1,0.6,0.6)
    love.graphics.print("Better Bitlife",staticFont,centeredTextLocation(14,2),win_h/2-240,0,2,2)
    --Play button
    button(centeredBoxLocation(300),(win_h/2)-75,300,150,5,green,red,blue,"PLAY",255,1,true,true,false)
  end
  --When the game starts, the rest of the images/buttons load and the player gets to play!
  if hasGameStart == true then
    if characterCreated == false then
      if characterNamed == false then
        enterName()
      end
      if gender == "" then
        button(centeredBoxLocation(350)-200,300,350,60,5,40,40,40,"MALE",255,4,true,true,false)
        button(centeredBoxLocation(350)+200,300,350,60,5,40,40,40,"FEMALE",255,5,true,true,false)
      elseif gender == "MALE" then
        button(centeredBoxLocation(350)-200,300,350,60,5,green,red,blue,"MALE",255,4,false,false,false)
        button(centeredBoxLocation(350)+200,300,350,60,5,40,40,40,"FEMALE",255,5,true,true,false)
      elseif gender == "FEMALE" then
        button(centeredBoxLocation(350)-200,300,350,60,5,40,40,40,"MALE",255,4,true,true,false)
        button(centeredBoxLocation(350)+200,300,350,60,5,green,red,blue,"FEMALE",255,5,false,false,false)
      end
      button(centeredBoxLocation(350),win_h-300,350,100,5,green,red,blue,"START",255,7,true,true,false)


    elseif characterCreated == true then
      --Plus 1 button
      button(centeredBoxLocation(230),win_h-260,230,230,5,green,red,blue,"+1",255,3,true,true,false)
      --Name and age print to screen
      love.graphics.setColor(1,1,1)
      love.graphics.print(name .. " - " .. gender,staticFont,30,22,0,.75,1)
      love.graphics.print("Age: " .. age,staticFont,centeredTextLocation(#tostring(age)+5,1),win_h-320,0,1,1)

      if choiceTime == true then
        choiceButtons(1)
      elseif outcome > 0 then
        if outcomeLoaded == false then
          counter = 1
          lineNum = (randomStory*20)-(3*outcome)+2+math.random(0,1)
          outcomeChoice = "this shouldn't appear"
          file = io.open("textFiles/eventOutcomes".. ageEvent .. ".txt", "r")
          for line in file:lines() do
            if counter == lineNum then
              outcomeChoice = line
              break
            end
            counter = counter + 1
          end
          file:close()
          outcomeLoaded = true
        end
        button(centeredBoxLocation(win_w/1.1),200,win_w/1.1,35,5,70,70,70,outcomeChoice,255,2,false,false,false)
      end
      --Left title button
      button(30,win_h-260,352,44,5,green,blue,red,"Player Choices",255,2,false,false,false)
      --Left side buttons
      button(30,win_h-204,170,50,5,green,blue,red,"Option 1",255,8,true,false,false)
      button(30,win_h-142,170,50,5,green,blue,red,"Option 2",255,9,true,false,false)
      button(30,win_h-80,170,50,5,green,blue,red,"Option 3",255,10,true,false,false)
      button(centeredBoxLocation(230)-182,win_h-204,170,50,5,green,blue,red,"Option 4",255,11,true,false,false)
      button(centeredBoxLocation(230)-182,win_h-142,170,50,5,green,blue,red,"Option 5",255,12,true,false,false)
      button(centeredBoxLocation(230)-182,win_h-80,170,50,5,green,blue,red,"Option 6",255,13,true,false,false)

      --Right title button
      button(centeredBoxLocation(230)+242,win_h-260,352,44,5,green,blue,red,"Character Stats",255,2,false,false,false)
      --Right side buttons
      button(centeredBoxLocation(230)+242,win_h-204,170,50,5,green,blue,red,"Relations",255,2,true,false,false)
      button(centeredBoxLocation(230)+242,win_h-142,170,50,5,green,blue,red,"Finance",255,2,true,false,false)
      button(centeredBoxLocation(230)+242,win_h-80,170,50,5,green,blue,red,"Occupation",255,2,true,false,false)
      button(win_w-200,win_h-204,170,50,5,green,blue,red,"Education",255,2,true,false,false)
      button(win_w-200,win_h-142,170,50,5,green,blue,red,"Health",255,2,true,false,false)
      button(win_w-200,win_h-80,170,50,5,green,blue,red,"Purpose",255,2,true,false,false)
    end
  end
end

--Returns the x location for text to be centered in the screen
function centeredTextLocation(textLength,textSize)
  return win_w/2 - (12.5*textLength*textSize)
end
--Returns the location for a rectangle to be centered (like a button) in the screen.
function centeredBoxLocation(boxWidth)
  return win_w/2 - (boxWidth/2)
end

function inList(character,lst)
  isInList = false
  for i=1,#lst do
    if character == lst[i] then
      isInList = true
      break
    end
  end
  return isInList
end

--function which allows you to create buttons the player can press with autosizing text optional
function button(xLocation,yLocation,width,height,lineWidth,color1,color2,color3,text,textColor,buttonFunctionNumber,hoverEvent,singlePress,dontStretchText)
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
      if singlePress == true then
        pressed = true
      end
    end
  else
    buttonColor = textColor
  end
  love.graphics.setColor(buttonColor/255,buttonColor/255,buttonColor/255)
  if dontStretchText == false then
    love.graphics.print(text,staticFont,xLocation+(width/8),yLocation+(height/15),0,width/(#text*34.0136),height*0.0155)
  elseif dontStretchText == true then
    love.graphics.print(text,staticFont,xLocation+(width/2-10)-(12.3*#text),yLocation+(height/15),0,1,height*0.0155)
  end
end

--The function that is called when a user presses a button. The command that is run depends on the number.
function buttonFunction(number)
  if number == 1 then
    gameStart()
  elseif number == 2 then
    --Dead button, doesn't do anything---
  elseif number == 3 then
    increaseAge()
  elseif number == 4 then
    gender = "MALE"
  elseif number == 5 then
    gender = "FEMALE"
  elseif number == 6 then
    nameBoxSelected = true
  elseif number == 7 then
    if #name >= 2 and gender ~= "" then
      characterCreated = true
    else love.graphics.print("Enter all information",staticFont,centeredTextLocation(21.5,1),200,0,1,1)
    end
  --Choice functions
  elseif number == 8 then
    outcome = 6
    choiceTime = false
    roundCompleted = true
  elseif number == 9 then
    outcome = 5
    choiceTime = false
    roundCompleted = true
  elseif number == 10 then
    outcome = 4
    choiceTime = false
    roundCompleted = true
  elseif number == 11 then
    outcome = 3
    choiceTime = false
    roundCompleted = true
  elseif number == 12 then
    outcome = 2
    choiceTime = false
    roundCompleted = true
  elseif number == 13 then
    outcome = 1
    choiceTime = false
    roundCompleted = true
  end
end

-- List of functions that go in buttonFunction()
function gameStart()
  hasGameStart = true
end
function increaseAge()
  if pressed == false and roundCompleted == true then
    age = age + 1
    roundCompleted = false
    choiceTime = true
    initialLoad = false
    outcome = -1
    outcomeLoaded = false
  end
end

--Function called for every random choice event
function choiceButtons(choiceEvent)
  if initialLoad == false then
    if age <= 4 then
      ageEvent = 1
    elseif age <= 8 then
      ageEvent = 2
    elseif age <= 12 then
      ageEvent = 3
    elseif age <= 18 then
      ageEvent = 4
    elseif age <= 22 then
      ageEvent = 5
    elseif age <= 35 then
      ageEvent = 6
    elseif age <= 50 then
      ageEvent = 7
    elseif age <= 70 then
      ageEvent = 8
    else
      ageEvent = 9
    end

    randomStory = math.random(3)
    if randomStory == previousStory then 
      randomStory = randomStory + 1
    end
    if randomStory > 3 then 
      randomStory = randomStory - 2
    end
    theLine = (randomStory*9)-6
    previousStory = randomStory
    count = 1

    story = ""
    firstChoiceText = ""
    secondChoiceText = ""
    thirdChoiceText = ""
    fourthChoiceText = ""
    fifthChoiceText = ""
    sixthChoiceText = ""

    file = io.open("textFiles/randomEventText".. ageEvent .. ".txt", "r")
    for line in file:lines() do
      if count == theLine then
        story = line
      elseif count == theLine+1 then
        firstChoiceText = line
      elseif count == theLine+2 then
        secondChoiceText = line
      elseif count == theLine+3 then
        thirdChoiceText = line
      elseif count == theLine+4 then
        fourthChoiceText = line
      elseif count == theLine+5 then
        fifthChoiceText = line
      elseif count == theLine+6 then
        sixthChoiceText = line
      end
      count = count + 1
    end
    initialLoad = true
    file:close()
  end

  button(centeredBoxLocation(win_w/1.15),100,win_w/1.15,35,5,70,70,70,story,255,2,false,false,false)
  button(80,175,win_w/2.5,50,5,blue,red,green,firstChoiceText,255,2,false,false,false)
  button(80,250,win_w/2.5,50,5,blue,red,green,secondChoiceText,255,2,false,false,false)
  button(80,325,win_w/2.5,50,5,blue,red,green,thirdChoiceText,255,2,false,false,false)
  button(win_w-(win_w/2)+20,175,win_w/2.5,50,5,blue,red,green,fourthChoiceText,255,2,false,false,false)
  button(win_w-(win_w/2)+20,250,win_w/2.5,50,5,blue,red,green,fifthChoiceText,255,2,false,false,false)
  button(win_w-(win_w/2)+20,325,win_w/2.5,50,5,blue,red,green,sixthChoiceText,255,2,false,false,false)
end
