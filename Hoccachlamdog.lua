-- Tạo GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "CrawlUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 10, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "R6 Posing"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 50)
button.Position = UDim2.new(0, 10, 0, 60)
button.Text = "Crawl (Bò)"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

-- Hàm thay đổi tư thế bò
local function crawl(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end
	
	local function adjust(partName, cf)
		local part = character:FindFirstChild(partName)
		if part and part:FindFirstChildOfClass("Motor6D") then
			part:FindFirstChildOfClass("Motor6D").Transform = cf
		end
	end

	adjust("Left Arm", CFrame.Angles(math.rad(-90), 0, 0))
	adjust("Right Arm", CFrame.Angles(math.rad(-90), 0, 0))
	adjust("Left Leg", CFrame.Angles(math.rad(90), 0, 0))
	adjust("Right Leg", CFrame.Angles(math.rad(90), 0, 0))
	adjust("Torso", CFrame.new(0, -1, 0))
end

-- Khi nhấn nút
button.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	crawl(char)
end)
