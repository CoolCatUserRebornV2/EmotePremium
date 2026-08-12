local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- EMOTES
--==================================================

local Emotes = {
	["i got that feeling"] = "136345301342001",
	["Neck Roller"] = "110855869390004",
	["Jamal Brazil Groove"] = "83796130837213",
	["wall phase"] = "73061206570424",
	["Katseye --- ???"] = "121765042386581",
	["needy"] = "98126345395357",
	["moonwalk"] = "134048087973127",
	["raiden punch"] = "126264342780589",
	["IGTFG V2"] = "92127990487686",
	["goofy flap"] = "118417760427139"
}

--==================================================
-- REMOVE OLD GUI
--==================================================

local oldGui = playerGui:FindFirstChild("FEUGCEmoteGui")
if oldGui then
	oldGui:Destroy()
end

local oldIntro = playerGui:FindFirstChild("EmloPamIntro")
if oldIntro then
	oldIntro:Destroy()
end

--==================================================
-- INTRO
--==================================================

local introGui = Instance.new("ScreenGui")
introGui.Name = "EmloPamIntro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.DisplayOrder = 999
introGui.Parent = playerGui

local black = Instance.new("Frame")
black.Size = UDim2.fromScale(1, 1)
black.Position = UDim2.fromScale(0, 0)
black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
black.BackgroundTransparency = 0
black.BorderSizePixel = 0
black.Parent = introGui

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(0, 500, 0, 80)
introText.Position = UDim2.fromScale(0.5, 0.5)
introText.AnchorPoint = Vector2.new(0.5, 0.5)
introText.BackgroundTransparency = 1
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.TextTransparency = 0
introText.TextSize = 42
introText.Font = Enum.Font.GothamBold
introText.Text = ""
introText.Parent = black

local introWords = {
	"Ma",
	"de",
	"by",
	"Emlo",
	"pam"
}

for _, word in ipairs(introWords) do
	introText.Text = word
	task.wait(0.35)
end

local fadeInfo = TweenInfo.new(
	1.5,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local textFade = TweenService:Create(
	introText,
	fadeInfo,
	{
		TextTransparency = 1
	}
)

local blackFade = TweenService:Create(
	black,
	fadeInfo,
	{
		BackgroundTransparency = 1
	}
)

textFade:Play()
blackFade:Play()

blackFade.Completed:Wait()
introGui:Destroy()

--==================================================
-- MAIN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "FEUGCEmoteGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

--==================================================
-- OPEN/CLOSE BUTTON
--==================================================

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 55, 0, 55)
toggle.Position = UDim2.new(0, 20, 0.5, -27)
toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggle.Text = "≡"
toggle.TextSize = 28
toggle.Font = Enum.Font.GothamBold
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.BorderSizePixel = 0
toggle.AutoButtonColor = true
toggle.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 16)
toggleCorner.Parent = toggle

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 3
toggleStroke.Parent = toggle

--==================================================
-- MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 510)
frame.Position = UDim2.new(0.5, -125, 0.5, -255)
frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
frame.BorderSizePixel = 0
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 18)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 3
frameStroke.Parent = frame

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "UGC Emotes"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.Parent = frame

--==================================================
-- BUTTON CREATOR
--==================================================

local function createEmoteButton(name, y)
	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -20, 0, 38)
	button.Position = UDim2.new(0, 10, 0, y)

	button.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
	button.BorderSizePixel = 0

	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 16
	button.Font = Enum.Font.GothamBold

	button.Parent = frame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Parent = button

	return button
end

local button1 = createEmoteButton("i got that feeling", 48)
local button2 = createEmoteButton("Neck Roller", 93)
local button3 = createEmoteButton("Jamal Brazil Groove", 138)
local button4 = createEmoteButton("wall phase", 183)
local button5 = createEmoteButton("Katseye --- ???", 228)
local button6 = createEmoteButton("needy", 273)
local button7 = createEmoteButton("moonwalk", 318)
local button8 = createEmoteButton("raiden punch", 363)
local button9 = createEmoteButton("IGTFG V2", 408)
local button10 = createEmoteButton("goofy flap", 453)

--==================================================
-- ANIMATION SYSTEM
--==================================================

local currentTrack = nil

local function stopEmote()
	if currentTrack then
		pcall(function()
			currentTrack:Stop(0.15)
			currentTrack:Destroy()
		end)

		currentTrack = nil
	end
end

local function playEmote(id)
	stopEmote()

	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://" .. id

	local success, track = pcall(function()
		return animator:LoadAnimation(animation)
	end)

	animation:Destroy()

	if success and track then
		currentTrack = track
		track.Looped = true
		track:Play()
	end
end

--==================================================
-- BUTTON EVENTS
--==================================================

button1.MouseButton1Click:Connect(function()
	playEmote(Emotes["i got that feeling"])
end)

button2.MouseButton1Click:Connect(function()
	playEmote(Emotes["Neck Roller"])
end)

button3.MouseButton1Click:Connect(function()
	playEmote(Emotes["Jamal Brazil Groove"])
end)

button4.MouseButton1Click:Connect(function()
	playEmote(Emotes["wall phase"])
end)

button5.MouseButton1Click:Connect(function()
	playEmote(Emotes["Katseye --- ???"])
end)

button6.MouseButton1Click:Connect(function()
	playEmote(Emotes["needy"])
end)

button7.MouseButton1Click:Connect(function()
	playEmote(Emotes["moonwalk"])
end)

button8.MouseButton1Click:Connect(function()
	playEmote(Emotes["raiden punch"])
end)

button9.MouseButton1Click:Connect(function()
	playEmote(Emotes["IGTFG V2"])
end)

button10.MouseButton1Click:Connect(function()
	playEmote(Emotes["goofy flap"])
end)

--==================================================
-- STOP ON MOVEMENT / JUMP / SWIM / ETC.
--==================================================

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")

	humanoid.Running:Connect(function(speed)
		if speed > 0.1 then
			stopEmote()
		end
	end)

	humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping
			or newState == Enum.HumanoidStateType.Freefall
			or newState == Enum.HumanoidStateType.FallingDown
			or newState == Enum.HumanoidStateType.Climbing
			or newState == Enum.HumanoidStateType.Swimming
			or newState == Enum.HumanoidStateType.Seated
			or newState == Enum.HumanoidStateType.PlatformStanding
			or newState == Enum.HumanoidStateType.Ragdoll
			or newState == Enum.HumanoidStateType.Dead then

			stopEmote()
		end
	end)

	humanoid.Died:Connect(function()
		stopEmote()
	end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(character)
	stopEmote()
	setupCharacter(character)
end)

--==================================================
-- DRAGGING
--==================================================

local function makeDraggable(object)
	local dragging = false
	local dragStart
	local startPosition

	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(frame)
makeDraggable(toggle)

--==================================================
-- OPEN / CLOSE
--==================================================

local opened = true

toggle.MouseButton1Click:Connect(function()
	opened = not opened
	frame.Visible = opened
end)

--==================================================
-- RAINBOW OUTLINES
--==================================================

local strokes = {
	frameStroke,
	toggleStroke
}

for _, button in ipairs({
	button1,
	button2,
	button3,
	button4,
	button5,
	button6,
	button7,
	button8,
	button9,
	button10
}) do
	local stroke = button:FindFirstChildOfClass("UIStroke")

	if stroke then
		table.insert(strokes, stroke)
	end
end

RunService.RenderStepped:Connect(function()
	local hue = (tick() * 0.25) % 1
	local rainbowColor = Color3.fromHSV(hue, 1, 1)

	for _, stroke in ipairs(strokes) do
		if stroke then
			stroke.Color = rainbowColor
		end
	end
end)
