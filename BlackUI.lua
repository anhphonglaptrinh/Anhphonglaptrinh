-- UI bảng đen với các lựa chọn đúng / sai

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hàm tạo Frame đen với nội dung tuỳ chỉnh
local function createBlackFrame(titleText, bodyText)
	local screenGui = Instance.new("ScreenGui")
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 400, 0, 200)
	frame.Position = UDim2.new(0.5, -200, 0.5, -100)
	frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local title = Instance.new("TextLabel")
	title.Text = titleText
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 24
	title.Parent = frame

	local body = Instance.new("TextLabel")
	body.Text = bodyText
	body.Size = UDim2.new(1, 0, 0, 100)
	body.Position = UDim2.new(0, 0, 0.5, -20)
	body.BackgroundTransparency = 1
	body.TextColor3 = Color3.new(1, 1, 1)
	body.Font = Enum.Font.SourceSans
	body.TextSize = 22
	body.Parent = frame

	return screenGui
end

-- Giao diện chính
local mainGui = Instance.new("ScreenGui")
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 200)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainGui

local title = Instance.new("TextLabel")
title.Text = "Anh Phong đẹp trai nhất"
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = mainFrame

-- Nút Sai
local wrongBtn = Instance.new("TextButton")
wrongBtn.Text = "Sai"
wrongBtn.Size = UDim2.new(0.3, 0, 0, 50)
wrongBtn.Position = UDim2.new(0.05, 0, 1, -60)
wrongBtn.BackgroundColor3 = Color3.new(0.2, 0.1, 0.1)
wrongBtn.TextColor3 = Color3.new(1, 1, 1)
wrongBtn.Font = Enum.Font.SourceSans
wrongBtn.TextSize = 20
wrongBtn.Parent = mainFrame

-- Nút Đúng
local rightBtn = Instance.new("TextButton")
rightBtn.Text = "Đúng"
rightBtn.Size = UDim2.new(0.3, 0, 0, 50)
rightBtn.Position = UDim2.new(0.65, 0, 1, -60)
rightBtn.BackgroundColor3 = Color3.new(0.1, 0.2, 0.1)
rightBtn.TextColor3 = Color3.new(1, 1, 1)
rightBtn.Font = Enum.Font.SourceSans
rightBtn.TextSize = 20
rightBtn.Parent = mainFrame

-- Xử lý nút Sai
wrongBtn.MouseButton1Click:Connect(function()
	mainGui:Destroy()
	local angryGui = createBlackFrame("😡", "")
	task.wait(2)
	player:LoadCharacter()
end)

-- Xử lý nút Đúng
rightBtn.MouseButton1Click:Connect(function()
	mainGui:Destroy()
	createBlackFrame("✅", "Đúng là người thông minh có khác")
end)
