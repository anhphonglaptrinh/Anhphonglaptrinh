-- Tạo giao diện ban đầu
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ButtonSai = Instance.new("TextButton")
local ButtonDung = Instance.new("TextButton")

ScreenGui.Name = "BlackUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Bảng chính
Frame.Name = "MainPanel"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Size = UDim2.new(0, 400, 0, 200)
Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.1

-- Dòng chữ chính
TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0.3, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Anh Phong đẹp trai nhất đúng không?"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextScaled = true

-- Nút "Sai"
ButtonSai.Name = "ButtonSai"
ButtonSai.Parent = Frame
ButtonSai.Size = UDim2.new(0.4, 0, 0.25, 0)
ButtonSai.Position = UDim2.new(0.05, 0, 0.65, 0)
ButtonSai.Text = "❌ Sai"
ButtonSai.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ButtonSai.TextColor3 = Color3.new(1, 1, 1)
ButtonSai.Font = Enum.Font.GothamBold
ButtonSai.TextScaled = true
ButtonSai.BorderSizePixel = 0

-- Nút "Đúng"
ButtonDung.Name = "ButtonDung"
ButtonDung.Parent = Frame
ButtonDung.Size = UDim2.new(0.4, 0, 0.25, 0)
ButtonDung.Position = UDim2.new(0.55, 0, 0.65, 0)
ButtonDung.Text = "✅ Đúng"
ButtonDung.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
ButtonDung.TextColor3 = Color3.new(1, 1, 1)
ButtonDung.Font = Enum.Font.GothamBold
ButtonDung.TextScaled = true
ButtonDung.BorderSizePixel = 0

-- Bộ đếm số lần nhấn sai
local saiCount = 0

-- Hàm random vị trí trong giới hạn UI
local function getRandomPosition()
	local x = math.random(0, 300)
	local y = math.random(0, 120)
	return UDim2.new(0, x, 0, y)
end

-- Xử lý nút SAI
ButtonSai.MouseButton1Click:Connect(function()
	saiCount += 1
	if saiCount < 5 then
		ButtonSai.Position = getRandomPosition()
	else
		Frame.Visible = false

		local WrongFrame = Instance.new("Frame", ScreenGui)
		WrongFrame.Size = Frame.Size
		WrongFrame.Position = Frame.Position
		WrongFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		WrongFrame.BackgroundTransparency = 0.1
		WrongFrame.BorderSizePixel = 0

		local AngryLabel = Instance.new("TextLabel", WrongFrame)
		AngryLabel.Size = UDim2.new(1, 0, 1, 0)
		AngryLabel.BackgroundTransparency = 1
		AngryLabel.Text = "😡"
		AngryLabel.TextColor3 = Color3.new(1, 0, 0)
		AngryLabel.Font = Enum.Font.GothamBold
		AngryLabel.TextScaled = true

		wait(2)
		game.Players.LocalPlayer:Kick("tao là đẹp trai nhất🖕")
	end
end)

-- Xử lý nút ĐÚNG
ButtonDung.MouseButton1Click:Connect(function()
	Frame.Visible = false

	local NewPanel = Instance.new("Frame", ScreenGui)
	NewPanel.Size = Frame.Size
	NewPanel.Position = Frame.Position
	NewPanel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	NewPanel.BackgroundTransparency = 0.1
	NewPanel.BorderSizePixel = 0

	local Crown = Instance.new("TextLabel", NewPanel)
	Crown.Size = UDim2.new(1, 0, 0.2, 0)
	Crown.Position = UDim2.new(0, 0, 0, 0)
	Crown.Text = "👑"
	Crown.TextColor3 = Color3.new(1, 1, 0)
	Crown.BackgroundTransparency = 1
	Crown.Font = Enum.Font.GothamBold
	Crown.TextScaled = true

	local Message = Instance.new("TextLabel", NewPanel)
	Message.Size = UDim2.new(1, 0, 0.6, 0)
	Message.Position = UDim2.new(0, 0, 0.2, 0)
	Message.Text = "Thông minh lắm con trai của ta"
	Message.TextColor3 = Color3.new(1, 1, 1)
	Message.BackgroundTransparency = 1
	Message.Font = Enum.Font.GothamBold
	Message.TextScaled = true

	local CloseButton = Instance.new("TextButton", NewPanel)
	CloseButton.Size = UDim2.new(0, 40, 0, 40)
	CloseButton.Position = UDim2.new(1, -45, 0, 5)
	CloseButton.Text = "✖"
	CloseButton.TextColor3 = Color3.new(1, 1, 1)
	CloseButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.TextScaled = true

	CloseButton.MouseButton1Click:Connect(function()
		NewPanel:Destroy()
	end)
end)
