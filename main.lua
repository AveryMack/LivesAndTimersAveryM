-----------------------------------------------------------------------------------------
-- Title: LivesAndTimers
-- Name: Avery Mack
-- Course: ICS2O/3C
-- This program...
-- 
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- hide the status bar

-- sets the background colour
display.setDefault("background", 70/255, 16/255, 71/255)

-----------------------------------------------------------------------------------
-- LOCAL VARIBALES
-----------------------------------------------------------------------------------

-- create local variables 
local questionObject
local correctObject
local incorrectObject
local NumericTextField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator
local points = 0
local pointsObject 

-- variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3 
local heart1
local heart2


---------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------------

-- get rid of the status bar
display.setStatusBar(display.HiddenStatusBar)

local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number 
	randomNumber1 = math.random (10, 20)
	randomNumber2 = math.random (10, 20)
    randomOperator = math.random (1, 3)

    

	-- create question in text object 
	if randomOperator == 1 then 
		correctAnswer = randomNumber1 + randomNumber2
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. 	" = " 
	    

	elseif randomOperator == 2 then 
		correctAnswer = randomNumber1 - randomNumber2
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 ..  " = " 

		if (correctAnswer < 0) then
			correctAnswer = randomNumber2 - randomNumber1
			questionObject.text = randomNumber2 .. " - " .. randomNumber1 ..  " = " 
		end

	elseif randomOperator == 3 then
		randomNumber1 = math.random (1, 10)
		randomNumber2 = math.random (1, 10)
		correctAnswer = randomNumber1 * randomNumber2
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
    end 
end

local function HideCorrect()
	correctObject.isVisible = false 
	incorrectObject.isVisible = false 
	AskQuestion()
end 

local function HideIncorrect()
	incorrectObject.isVisible = false 
	correctObject.isVisible = false 
	AskQuestion()
end 

local function UpdateTime()

	-- decrement the number of seconds 
	secondsLeft = secondsLeft - 1 

	-- display the number of seconds left in the clock 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds 
		lives = lives - 1

		-- ** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A LOSE IMAGE
		-- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
		if (lives == 2) then
			heart2.isVisible = false
		elseif (lives == 1) then
			heart1.isVisible = false 
		end 

		-- ** CALL THE FUNCTION TO ASK A NEW QUESTION

	end 
end 


local function NumericFieldListener(event)
	-- User begins editing "numericField"
	if ( event.phase == "began" ) then 
		-- clear text field 
		event.target.text = ""
		
	elseif event.phase == "submitted" then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true 
			timer.performWithDelay(1500, HideCorrect)
			points = points + 1
			pointsObject.text = points 

		else -- they got it wrong
			incorrectObject.isVisible = true 
			timer.performWithDelay(1500, HideIncorrect) 
		end 	
    
    end 
end


-- function the calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinetly 
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end 


-----------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------

-- displays a question and sets the color
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/3, nil, 100) 
questionObject:setTextColor(0/255, 246/255, 0/255)

-- display a points object and set the colour
pointsObject = display.newText( "0 ", 900, 700, nil, 100)
pointsObject:setTextColor(255/255, 255/255, 255/255)
--pointsObject.text = " 0 "

-- display a clock object and set the color
clockObject = display.newText( " 5 ", 700, 700, nil, 100)

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7/8
heart1.y = display.contentHeight * 1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6/8
heart2.y = display.contentHeight * 1/7

-- create the correct text object and make it invisible 
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(0/255, 246/255, 0/255)
correctObject.isVisible = false 

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(225/255, 0/255, 0/255)
incorrectObject.isVisible = false 

-- create numeric field 
numericField = native.newTextField( 675, 263, 200, 100)
numericField.inputType = "number"

-- add the event listener for the numeric field 
numericField:addEventListener( "userInput", NumericFieldListener )

----------------------------------------------------------------------------------
-- FUNCTION CALLS
----------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()

StartTimer()












