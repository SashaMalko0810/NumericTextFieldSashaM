--Title: NumericTextFields
--Name: Sasha Malko
--Course: ICS2O/3C
--This program displays a math question and asks the user to answer in a numeric textfield
--terminal.
---------------------------------------------------------------------------------------------

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--sets the backgorund colour
display.setDefault("background", 251/255, 166/255, 250/255)

---------------------------------------------------------------------------------------------
--LOCAL VARIABLES
---------------------------------------------------------------------------------------------

--create local variables
local questionObject
local correctObject
local incorrectObject
local NumericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer

----------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
----------------------------------------------------------------------------------------------

local function AskQuestion()
	--generate 2 random numbers between a max. and a mn. number
	randomNumber1 = math.random(10,20)
	randomNumber2 = math.random(10,20)

	correctAnswer = randomNumber1 + randomNumber2 
		
	--create question in text object
	questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "=" 
end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end


local function NumericFieldListener(event)

	--user begins editiing "numericField"
	if (event.phase == "began") then

		--clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		--when the answer is sumbitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		--if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			incorrectObject.isVisible = false
			timer.performWithDelay(1000,HideCorrect)
		
		elseif (userAnswer) then
			correctObject.isVisible = false
			incorrectObject.isVisible = true
			timer.performWithDelay(1000,HideIncorrect)
		end
	end
end

----------------------------------------------------------------------------------------------
--OBJECT CREATION
----------------------------------------------------------------------------------------------

--displays a question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 80)
questionObject:setTextColor(27/255, 71/255, 144/255)

--create the correct text object and make it invisible
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(27/255, 144/255, 35/255)
correctObject.isVisible = false

--create the correct text object and make it invisible
incorrectObject = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(1, 0, 0)
incorrectObject.isVisible = false

--create numeric field
numericField = native.newTextField(600, display.contentHeight/2, 200, 100)
numericField.inputType = "number"

--add the event listener for the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

----------------------------------------------------------------------------------------------
--FUNCTION CALLS
----------------------------------------------------------------------------------------------

--call the function to ask the question
AskQuestion()